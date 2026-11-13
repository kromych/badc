
arm_neon_intrinsics.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	mov	x0, #0x2607             // =9735
               	mov	x1, #0xc6c3             // =50883
               	mov	x2, #0x201              // =513
               	sturh	w0, [x29, #-0x50]
               	sturh	w1, [x29, #-0x40]
               	sturh	w2, [x29, #-0x30]
               	mov	x0, #0x6445             // =25669
               	mov	x1, #0xccc9             // =52425
               	mov	x2, #0xa05              // =2565
               	sturh	w0, [x29, #-0x4e]
               	sturh	w1, [x29, #-0x3e]
               	sturh	w2, [x29, #-0x2e]
               	mov	x0, #0xa283             // =41603
               	mov	x1, #0xdad7             // =56023
               	mov	x2, #0x1a11             // =6673
               	sturh	w0, [x29, #-0x4c]
               	sturh	w1, [x29, #-0x3c]
               	sturh	w2, [x29, #-0x2c]
               	mov	x0, #0xe0c1             // =57537
               	mov	x1, #0xe0dd             // =57565
               	mov	x2, #0x3225             // =12837
               	sturh	w0, [x29, #-0x4a]
               	sturh	w1, [x29, #-0x3a]
               	sturh	w2, [x29, #-0x2a]
               	mov	x0, #0x1eff             // =7935
               	mov	x1, #0xeeeb             // =61163
               	mov	x2, #0x5241             // =21057
               	sturh	w0, [x29, #-0x48]
               	sturh	w1, [x29, #-0x38]
               	sturh	w2, [x29, #-0x28]
               	mov	x0, #0x5c3d             // =23613
               	mov	x1, #0xf4f1             // =62705
               	mov	x2, #0x7a65             // =31333
               	sturh	w0, [x29, #-0x46]
               	sturh	w1, [x29, #-0x36]
               	sturh	w2, [x29, #-0x26]
               	mov	x0, #0x9a7b             // =39547
               	mov	x1, #0x82ff             // =33535
               	mov	x2, #0xaa91             // =43665
               	sturh	w0, [x29, #-0x44]
               	sturh	w1, [x29, #-0x34]
               	sturh	w2, [x29, #-0x24]
               	mov	x0, #0xd8b9             // =55481
               	mov	x2, #0x8885             // =34949
               	mov	x3, #0xe2c5             // =58053
               	sub	x1, x29, #0x50
               	sturh	w0, [x29, #-0x42]
               	sturh	w2, [x29, #-0x32]
               	sturh	w3, [x29, #-0x22]
               	movi	v2.16b, #0x1d
               	ldur	q0, [x29, #-0x50]
               	ldur	q1, [x29, #-0x40]
               	eor	v3.16b, v0.16b, v1.16b
               	sshr	v4.16b, v0.16b, #0x7
               	shl	v0.16b, v0.16b, #0x1
               	and	v2.16b, v4.16b, v2.16b
               	eor	v0.16b, v0.16b, v2.16b
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x20
               	stur	q3, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	sub	x5, x29, #0x40
               	ldrb	w5, [x5, x0]
               	eor	x4, x4, x5
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x20
               	stur	q0, [x29, #-0x20]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldrb	w5, [x4, x0]
               	ldrb	w3, [x1, x0]
               	mov	x6, #0x1d               // =29
               	tst	x3, #0x80
               	csel	x6, x6, x2, ne
               	eor	x3, x6, x3, lsl #1
               	and	x3, x3, #0xff
               	sub	x6, x29, #0x40
               	ldrb	w6, [x6, x0]
               	eor	x3, x3, x6
               	cmp	w5, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0xb02              // =2818
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x1d14             // =7444
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0x2f26             // =12070
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x4138             // =16696
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x534a             // =21322
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0x655c             // =25948
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0x776e             // =30574
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x8980             // =35200
               	sturh	w0, [x29, #-0x2]
               	ldur	q0, [x29, #-0x10]
               	sub	x1, x29, #0x30
               	ldur	q1, [x29, #-0x30]
               	movi	v2.16b, #0xf
               	and	v1.16b, v1.16b, v2.16b
               	tbl	v0.16b, { v0.16b }, v1.16b
               	sub	x2, x29, #0x20
               	stur	q0, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	sub	x4, x29, #0x10
               	ldrb	w5, [x1, x0]
               	and	x5, x5, #0xf
               	ldrb	w4, [x4, x5]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	q0, [x29, #-0x50]
               	sub	x3, x29, #0x40
               	ldur	q1, [x29, #-0x40]
               	pmul	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x20]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x50
               	ldrb	w4, [x1, x2]
               	mov	x1, x0
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrb	w5, [x3, x2]
               	mov	x6, #0x1                // =1
               	lsl	x6, x6, x0
               	sxtw	x6, w6
               	and	x5, x5, x6
               	cbz	x5, <addr>
               	lsl	x5, x4, x0
               	and	x5, x5, #0xff
               	eor	x1, x1, x5
               	b	<addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, x2]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	ldur	q0, [x29, #-0x50]
               	sub	x2, x29, #0x40
               	ldur	q1, [x29, #-0x40]
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x3, x29, #0x20
               	stur	q0, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x1, x0]
               	ldrb	w6, [x2, x0]
               	eor	x5, x5, x6
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
