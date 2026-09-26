
cross_block_cse.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x2, x29, #0x28
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	mov	x1, #0x1                // =1
               	str	w1, [x2, #0x4]
               	mov	x1, #0x4                // =4
               	str	w1, [x2, #0x8]
               	mov	x1, #0x9                // =9
               	str	w1, [x2, #0xc]
               	mov	x1, #0x10               // =16
               	str	w1, [x2, #0x10]
               	mov	x1, #0x19               // =25
               	str	w1, [x2, #0x14]
               	mov	x1, #0x24               // =36
               	str	w1, [x2, #0x18]
               	mov	x1, #0x31               // =49
               	str	w1, [x2, #0x1c]
               	mov	x1, #0x40               // =64
               	str	w1, [x2, #0x20]
               	mov	x1, #0x51               // =81
               	str	w1, [x2, #0x24]
               	ldrsw	x1, [x2, #0x1c]
               	cmp	w1, #0xc8
               	b.le	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0x31
               	b.ne	<addr>
               	mov	x1, #0x99               // =153
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	mul	x3, x1, x5
               	lsr	x3, x3, #32
               	mul	x6, x3, x4
               	sub	x1, x1, x6
               	ldrsw	x1, [x2, x1, lsl #2]
               	add	x0, x0, x1
               	cmp	w0, #0xc8
               	b.gt	<addr>
               	mov	x1, x3
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x28
               	mov	x1, #0x423f             // =16959
               	movk	x1, #0xf, lsl #16
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x2, x1, x5
               	lsr	x2, x2, #32
               	mul	x6, x2, x4
               	sub	x1, x1, x6
               	ldrsw	x1, [x3, x1, lsl #2]
               	add	x0, x0, x1
               	cmp	w0, #0xc8
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	scvtf	d0, x0
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	s0, x0
               	fmov	s1, #4.00000000
               	fdiv	s0, s0, s1
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ucvtf	d0, x1
               	mov	x16, #0x43e0000000000000 // =4890909195324358656
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.ne	<addr>
               	ucvtf	s0, x1
               	mov	x16, #0x5f000000        // =1593835520
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.ne	<addr>
               	sub	x2, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	mov	x4, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mul	x3, x0, x4
               	add	x3, x3, #0x1
               	ldr	x5, [x2, x0, lsl #3]
               	cmp	x5, #0x0
               	b.le	<addr>
               	ldr	x5, [x2, x0, lsl #3]
               	madd	x1, x5, x3, x1
               	b	<addr>
               	sub	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	cmp	x1, #0x42
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
