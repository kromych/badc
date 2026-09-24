
c11_atomic_ops.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x2, #0x64               // =100
               	stur	w2, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	ldar	w0, [x1]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfa               // =250
               	stlr	w0, [x1]
               	ldar	w0, [x1]
               	mov	x17, #0xfa              // =250
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldaddal	w0, w3, [x1]
               	mov	x17, #0xfa              // =250
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x20]
               	eor	x3, x3, #0xff
               	cbz	w3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x32               // =50
               	neg	x16, x3
               	ldaddal	w16, w3, [x1]
               	eor	x3, x3, #0xff
               	cbz	w3, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x20]
               	mov	x17, #0xcd              // =205
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xf00              // =3840
               	ldsetal	w3, w3, [x1]
               	mov	x17, #0xcd              // =205
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x20]
               	mov	x17, #0xfcd             // =4045
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xff               // =255
               	mvn	x16, x3
               	ldclral	w16, w3, [x1]
               	mov	x17, #0xfcd             // =4045
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x20]
               	mov	x17, #0xcd              // =205
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xf                // =15
               	ldeoral	w3, w4, [x1]
               	mov	x17, #0xcd              // =205
               	eor	x4, x4, x17
               	cbz	w4, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w4, [x29, #-0x20]
               	mov	x17, #0xc2              // =194
               	eor	x4, x4, x17
               	cbz	w4, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x7                // =7
               	swpal	w4, w5, [x1]
               	cmp	w5, #0xc2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w5, [x29, #-0x20]
               	eor	x5, x5, #0x7
               	cbz	w5, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0x63               // =99
               	casal	w4, w5, [x1]
               	cmp	w4, #0x7
               	cset	x4, eq
               	cmp	w4, #0x1
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x20]
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x4d2              // =1234
               	mov	x3, x0
               	casal	w3, w4, [x1]
               	cmp	w3, #0x5
               	cset	x1, eq
               	cbz	x1, <addr>
               	cbz	x1, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x20]
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	ldaddalb	w2, w0, [x0]
               	and	x0, x0, #0xff
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x18]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9c40             // =40000
               	sturh	w0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	mov	x1, #0x7530             // =30000
               	ldaddalh	w1, w0, [x0]
               	and	x0, x0, #0xffff
               	mov	x17, #0x9c40            // =40000
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x10]
               	mov	x17, #0x1170            // =4464
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x1                // =1
               	swpal	x1, x0, [x0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x3
               	b	<addr>
