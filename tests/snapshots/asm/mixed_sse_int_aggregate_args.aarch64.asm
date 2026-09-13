
mixed_sse_int_aggregate_args.aarch64:	file format elf64-littleaarch64

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

<docall>:
               	mov	x4, x0
               	ldr	d1, [x1]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.ne	<addr>
               	ldr	x0, [x1, #0x8]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	ret
               	cmp	x4, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	ldr	x0, [x2]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	ldr	d1, [x2, #0x8]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x3ff4000000000000 // =4608308318706860032
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	ldr	d0, [x3]
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x3, #0x8]
               	mov	x0, #0x4012000000000000 // =4616752568008179712
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	mov	x2, #0x400c000000000000 // =4615063718147915776
               	mov	x3, #0x4012000000000000 // =4616752568008179712
               	mov	x4, #0x3ff4000000000000 // =4608308318706860032
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	sxtw	x0, w0
               	ret
               	fmov	d16, x4
               	fmov	d17, x4
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	fmov	d16, x2
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x3
               	fmov	d17, x3
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
