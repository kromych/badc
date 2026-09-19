
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
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x18
               	and	x0, x2, #0x7
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x30
               	and	x0, x1, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x50
               	and	x3, x0, #0xf
               	cbz	w3, <addr>
               	mov	x0, #0xd                // =13
               	ret
               	add	x3, x0, #0x10
               	and	x3, x3, #0xf
               	cbz	w3, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	fmov	d0, #2.50000000
               	str	d0, [x2]
               	mov	x3, #0x1                // =1
               	str	x3, [x1]
               	mov	x4, #0x2                // =2
               	str	x4, [x1, #0x8]
               	mov	x5, #0x3                // =3
               	str	x5, [x0, #0x10]
               	mov	x6, #0x4                // =4
               	str	x6, [x0, #0x18]
               	mrs	x6, TPIDR_EL0
               	add	x6, x6, #0x0, lsl #12   // =0x0
               	add	x6, x6, #0x10
               	strb	w3, [x6]
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x20
               	strb	w4, [x3]
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0x40
               	strb	w5, [x4]
               	ldr	d1, [x2]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x2, x1
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x18]
               	add	x0, x1, x0
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	ldrb	w0, [x6]
               	ldrb	w1, [x3]
               	add	x0, x0, x1
               	ldrb	w1, [x4]
               	add	x0, x0, x1
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x0                // =0
               	ret

<block_scope_boundaries>:
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x78
               	and	x0, x3, #0x7
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x50
               	and	x0, x1, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0xa8
               	and	x0, x4, #0x7
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0xc0
               	and	x0, x2, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d0, #1.50000000
               	str	d0, [x3]
               	mov	x5, #0x3                // =3
               	str	x5, [x1]
               	mov	x6, #0x4                // =4
               	str	x6, [x1, #0x8]
               	mov	x0, #0x5                // =5
               	str	x0, [x4]
               	mov	x7, #0x6                // =6
               	str	x7, [x2]
               	mov	x8, #0x7                // =7
               	str	x8, [x2, #0x8]
               	mrs	x9, TPIDR_EL0
               	add	x9, x9, #0x0, lsl #12   // =0x0
               	add	x9, x9, #0x10
               	mov	x10, #0x1               // =1
               	strb	w10, [x9]
               	mrs	x10, TPIDR_EL0
               	add	x10, x10, #0x0, lsl #12 // =0x0
               	add	x10, x10, #0x18
               	mov	x11, #0x2               // =2
               	strb	w11, [x10]
               	mrs	x11, TPIDR_EL0
               	add	x11, x11, #0x0, lsl #12 // =0x0
               	add	x11, x11, #0x20
               	strb	w5, [x11]
               	mrs	x5, TPIDR_EL0
               	add	x5, x5, #0x0, lsl #12   // =0x0
               	add	x5, x5, #0x40
               	strb	w6, [x5]
               	ldr	d1, [x3]
               	fcmp	d1, d0
               	b.ne	<addr>
               	ldr	x3, [x4]
               	cmp	x3, #0x5
               	b.eq	<addr>
               	ret
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	ldr	x1, [x2]
               	add	x0, x0, x1
               	ldr	x1, [x2, #0x8]
               	add	x0, x0, x1
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, x7
               	ret
               	ldrb	w0, [x9]
               	ldrb	w1, [x10]
               	add	x0, x0, x1
               	ldrb	w1, [x11]
               	add	x0, x0, x1
               	ldrb	w1, [x5]
               	add	x0, x0, x1
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, x8
               	ret
               	mov	x0, #0x0                // =0
               	ret

<wide_array_boundary>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0xe0
               	and	x1, x0, #0xf
               	cbz	w1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	add	x1, x0, #0x10
               	and	x1, x1, #0xf
               	cbz	w1, <addr>
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
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
