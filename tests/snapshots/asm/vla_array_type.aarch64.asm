
vla_array_type.aarch64:	file format elf64-littleaarch64

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

<one_dim>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	lsl	x5, x0, #2
               	add	x17, x5, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	mov	x1, #0x0                // =0
               	mov	x3, #0xa                // =10
               	cmp	w1, w0
               	b.ge	<addr>
               	mul	x4, x1, x3
               	str	w4, [x2, x1, lsl #2]
               	add	x1, x1, #0x1
               	cmp	w1, w0
               	b.lt	<addr>
               	lsl	x1, x0, #2
               	cmp	x5, x1
               	b.ne	<addr>
               	ldrsw	x1, [x2, #0x4]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	ldrsw	x1, [x2, #0x8]
               	cmp	w1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x2, x5
               	sub	x3, x1, x2
               	cmp	x3, x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sdiv	x3, x3, x5
               	cmp	x3, #0x1
               	b.ne	<addr>
               	cmp	x1, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x3, [x2, #0xc]
               	cmp	w3, #0x1e
               	b.ne	<addr>
               	sub	x1, x1, x5
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x3, x5, #1
               	add	x1, x1, x3
               	sub	x1, x1, x3
               	cmp	x1, x2
               	b.ne	<addr>
               	add	x3, x1, #0x4
               	add	x2, x2, #0x4
               	cmp	x3, x2
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	ldrsw	x1, [x1, x0, lsl #2]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<two_dim>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	mov	x17, #0xc               // =12
               	mul	x11, x0, x17
               	add	x17, x11, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x7, sp
               	sub	x7, x7, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x7
               	mov	x17, #0xc               // =12
               	mul	x12, x0, x17
               	add	x17, x12, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x6, sp
               	sub	x6, x6, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x6
               	mov	x1, #0x0                // =0
               	mov	x8, #0x3                // =3
               	mov	x9, #0xc                // =12
               	cmp	w1, w0
               	b.ge	<addr>
               	mul	x4, x1, x9
               	add	x3, x7, x4
               	mul	x2, x1, x8
               	str	w2, [x3]
               	add	x4, x6, x4
               	add	x5, x2, #0x64
               	str	w5, [x4]
               	add	x10, x2, #0x1
               	str	w10, [x3, #0x4]
               	add	x10, x5, #0x1
               	str	w10, [x4, #0x4]
               	add	x2, x2, #0x2
               	str	w2, [x3, #0x8]
               	add	x2, x5, #0x2
               	str	w2, [x4, #0x8]
               	add	x1, x1, #0x1
               	cmp	w1, w0
               	b.lt	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	cmp	x11, x1
               	b.ne	<addr>
               	cmp	x12, x11
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x7, #0x14]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x6, #0x14]
               	cmp	w1, #0x69
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x7, #0x14
               	sub	x1, x1, x7
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x0, #0x1
               	sxtw	x1, w1
               	mov	x17, #0xc               // =12
               	mul	x2, x1, x17
               	add	x3, x7, x2
               	ldrsw	x3, [x3]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	cmp	w3, w1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x3, x7, #0xc
               	sub	x3, x3, x7
               	cmp	x3, #0xc
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x6, x2
               	ldrsw	x2, [x2, #0x8]
               	add	x1, x1, #0x64
               	add	x1, x1, #0x2
               	cmp	w2, w1
               	b.ne	<addr>
               	lsl	x5, x0, #3
               	add	x17, x5, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	mov	x1, #0x0                // =0
               	mov	x3, #0xc                // =12
               	cmp	w1, w0
               	b.ge	<addr>
               	mul	x4, x1, x3
               	add	x4, x6, x4
               	str	x4, [x2, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, w0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	cmp	x5, x1
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	ldr	x1, [x2, x0, lsl #3]
               	ldrsw	x1, [x1, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x64
               	add	x0, x0, #0x2
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	add	x0, x20, #0x4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x2
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
