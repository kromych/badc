
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
               	ldr	d1, [x1]
               	fmov	d2, #2.50000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	ldr	x0, [x2]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	ldr	d1, [x2, #0x8]
               	fmov	d2, #0.50000000
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	fmov	d1, #1.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	ldr	d0, [x3]
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x3, #0x8]
               	fmov	d1, #4.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	fmov	d0, #2.50000000
               	fmov	d1, #0.50000000
               	fmov	d2, #3.50000000
               	fmov	d3, #4.50000000
               	fmov	d4, #1.25000000
               	fcmp	d0, d0
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	d4, d4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	fcmp	d2, d2
               	b.ne	<addr>
               	fcmp	d3, d3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
