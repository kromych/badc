
bool_normalize_c99.aarch64:	file format elf64-littleaarch64

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

<rti>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<rtd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #-0x7               // =-7
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x100              // =256
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	fmov	d0, #0.50000000
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	cset	x0, ne
               	and	x0, x0, #0xff
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	cset	x0, ne
               	and	x0, x0, #0xff
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w20, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	w21, #0x7
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	cmp	w0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x7b               // =123
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w20, #0x1
               	b.ne	<addr>
               	cbnz	x21, <addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
