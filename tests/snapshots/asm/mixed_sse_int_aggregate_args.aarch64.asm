
mixed_sse_int_aggregate_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x3, [x16]
               	str	x4, [x16, #0x8]
               	sub	x16, x29, #0x30
               	str	d1, [x16]
               	str	d2, [x16, #0x8]
               	mov	x1, x2
               	sub	x0, x29, #0x10
               	ldr	d1, [x0]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	cmp	x0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	d1, [x0, #0x8]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	mov	x0, #0x3ff4000000000000 // =4608308318706860032
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	sub	x0, x29, #0x30
               	ldr	d0, [x0]
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4012000000000000 // =4616752568008179712
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<docall>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	d1, [x3]
               	ldr	d2, [x3, #0x8]
               	mov	x3, x2
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x4, [x3, #0x8]
               	ldr	x3, [x3]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x10
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x1
               	str	d16, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	mov	x1, #0xb                // =11
               	str	x1, [x0]
               	sub	x0, x29, #0x20
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x1
               	str	d16, [x0, #0x8]
               	sub	x0, x29, #0x30
               	mov	x1, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x1
               	str	d16, [x0]
               	sub	x0, x29, #0x30
               	mov	x1, #0x4012000000000000 // =4616752568008179712
               	fmov	d16, x1
               	str	d16, [x0, #0x8]
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	sub	x3, x29, #0x30
               	mov	x4, #0x3ff4000000000000 // =4608308318706860032
               	fmov	d0, x4
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
