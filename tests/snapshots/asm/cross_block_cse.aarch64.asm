
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
               	mov	x3, #0x0                // =0
               	str	w3, [x2]
               	mov	x0, #0x1                // =1
               	str	w0, [x2, #0x4]
               	mov	x0, #0x4                // =4
               	str	w0, [x2, #0x8]
               	mov	x0, #0x9                // =9
               	str	w0, [x2, #0xc]
               	mov	x0, #0x10               // =16
               	str	w0, [x2, #0x10]
               	mov	x0, #0x19               // =25
               	str	w0, [x2, #0x14]
               	mov	x0, #0x24               // =36
               	str	w0, [x2, #0x18]
               	mov	x0, #0x31               // =49
               	str	w0, [x2, #0x1c]
               	mov	x0, #0x40               // =64
               	str	w0, [x2, #0x20]
               	mov	x0, #0x51               // =81
               	str	w0, [x2, #0x24]
               	mov	x0, #0x7                // =7
               	mov	x1, x3
               	cmp	w0, #0x0
               	b.le	<addr>
               	ldrsw	x4, [x2, x0, lsl #2]
               	add	x1, x1, x4
               	cmp	w1, #0xc8
               	b.gt	<addr>
               	mov	x0, x3
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cmp	w1, #0x31
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x28
               	mov	x0, #0x99               // =153
               	mov	x6, #0xa                // =10
               	mov	x7, #0x999a             // =39322
               	movk	x7, #0x1999, lsl #16
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	mul	x4, x0, x7
               	lsr	x5, x4, #32
               	mul	x2, x5, x6
               	sub	x2, x0, x2
               	ldrsw	x2, [x3, x2, lsl #2]
               	add	x1, x1, x2
               	cmp	w1, #0xc8
               	b.gt	<addr>
               	mov	x0, x5
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cmp	w1, #0x23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x28
               	mov	x0, #0x423f             // =16959
               	movk	x0, #0xf, lsl #16
               	mov	x6, #0xa                // =10
               	mov	x7, #0x999a             // =39322
               	movk	x7, #0x1999, lsl #16
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	mul	x4, x0, x7
               	lsr	x5, x4, #32
               	mul	x2, x5, x6
               	sub	x2, x0, x2
               	ldrsw	x2, [x3, x2, lsl #2]
               	add	x1, x1, x2
               	cmp	w1, #0xc8
               	b.gt	<addr>
               	mov	x0, x5
               	cmp	w0, #0x0
               	b.gt	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	scvtf	d0, x0
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fdiv	d0, d0, d17
               	mov	x2, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	s0, x0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s0, s0, s17
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.ne	<addr>
               	ucvtf	d0, x1
               	mov	x0, #0x43e0000000000000 // =4890909195324358656
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	ucvtf	s0, x1
               	mov	x0, #0x5f000000         // =1593835520
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.ne	<addr>
               	sub	x2, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x2, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x2, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x6, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x6
               	b.ge	<addr>
               	mul	x4, x0, x6
               	add	x3, x4, #0x1
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
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
