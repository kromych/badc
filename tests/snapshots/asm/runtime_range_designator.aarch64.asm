
runtime_range_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<check_once_eval>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x3, x0
               	sxtw	x3, w3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	sub	x0, x29, #0x48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x2, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x2, #0x38]
               	str	x10, [x0, #0x38]
               	ldrb	w10, [x2, #0x40]
               	strb	w10, [x0, #0x40]
               	ldrb	w10, [x2, #0x41]
               	strb	w10, [x0, #0x41]
               	ldrb	w10, [x2, #0x42]
               	strb	w10, [x0, #0x42]
               	ldrb	w10, [x2, #0x43]
               	strb	w10, [x0, #0x43]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x4, [x0]
               	add	x4, x4, #0x1
               	str	w4, [x0]
               	sub	x0, x29, #0x48
               	str	w3, [x0]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0xc]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x10]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x14]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x18]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x1c]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x20]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x24]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x28]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x2c]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x30]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x34]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x38]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x3c]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x40]
               	ldrsw	x0, [x1]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, x1, lsl #2]
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x11
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<check_resume_and_gap>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x0, w0
               	sub	x1, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	sxtw	x2, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	sxtw	x4, w2
               	sub	x1, x29, #0x18
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x18
               	mov	w2, w0
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x18
               	mov	w3, w0
               	str	w3, [x1, #0xc]
               	mov	x5, #0x2a               // =42
               	sub	x1, x29, #0x18
               	str	w5, [x1, #0x10]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x14]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x1, w4
               	cmp	x1, x0
               	cset	x4, ne
               	mov	x1, #0x1                // =1
               	cbnz	x4, <addr>
               	sxtw	x1, w2
               	cmp	x1, x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x1, w3
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_override>:
               	sxtw	x0, w0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x2]
               	sxtw	x3, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	add	x4, x4, #0x1
               	str	w4, [x1]
               	sxtw	x4, w3
               	mov	w5, w0
               	mov	w6, w0
               	mov	w7, w0
               	add	x1, x0, #0x7
               	sxtw	x3, w1
               	sxtw	x8, w3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x9, [x3]
               	add	x9, x9, #0x1
               	str	w9, [x3]
               	sxtw	x8, w8
               	ldrsw	x1, [x2]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	ret
               	sxtw	x3, w4
               	cmp	x3, x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sxtw	x1, w5
               	cmp	x1, x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sxtw	x1, w6
               	cmp	x1, x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x1, w7
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	sxtw	x2, w8
               	add	x1, x0, #0x7
               	sxtw	x1, w1
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	w4, w0
               	add	x1, x0, #0x1
               	sxtw	x5, w1
               	mov	w6, w1
               	mov	w2, w1
               	cmp	x3, x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x1, w4
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	sxtw	x3, w5
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x3, ne
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	sxtw	x3, w6
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxtw	x1, w2
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_widths>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sxtw	x0, w0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x4]
               	sub	x1, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	mov	x2, #0x41               // =65
               	sub	x1, x29, #0x18
               	strb	w2, [x1, #0x2]
               	sub	x1, x29, #0x18
               	mov	x2, #0x41               // =65
               	strb	w2, [x1, #0x3]
               	sub	x1, x29, #0x18
               	mov	x2, #0x41               // =65
               	strb	w2, [x1, #0x4]
               	sub	x1, x29, #0x18
               	mov	x2, #0x41               // =65
               	strb	w2, [x1, #0x5]
               	sxtw	x2, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	sxtw	x1, w2
               	sxth	x2, w1
               	mov	x17, #0xffff            // =65535
               	and	x6, x2, x17
               	sxtw	x3, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x5, [x1]
               	add	x5, x5, #0x1
               	str	w5, [x1]
               	sxtw	x3, w3
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	mul	x5, x3, x17
               	sub	x1, x29, #0x60
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x7]
               	str	x10, [x1]
               	ldr	x10, [x7, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x7, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x7, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x8, [x1]
               	add	x8, x8, #0x1
               	str	w8, [x1]
               	scvtf	d0, x3
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fdiv	d0, d0, d17
               	sub	x1, x29, #0x60
               	str	d0, [x1, #0x8]
               	sub	x1, x29, #0x60
               	ldr	x7, [x1, #0x8]
               	str	x7, [x1, #0x10]
               	sub	x1, x29, #0x10
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x7]
               	str	x10, [x1]
               	ldrb	w10, [x7, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x7, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x7, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x7, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x8, [x1]
               	add	x8, x8, #0x1
               	str	w8, [x1]
               	scvtf	s0, x3
               	mov	x1, #0x40800000         // =1082130432
               	fmov	s17, w1
               	fdiv	s0, s0, s17
               	sub	x1, x29, #0x10
               	str	s0, [x1]
               	sub	x1, x29, #0x10
               	ldr	w3, [x1]
               	str	w3, [x1, #0x4]
               	sub	x1, x29, #0x10
               	ldr	w3, [x1]
               	str	w3, [x1, #0x8]
               	ldrsw	x1, [x4]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x18
               	ldrb	w1, [x1, #0x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x3, #0x0                // =0
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	mov	x1, #0x0                // =0
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrb	w1, [x1, #0x6]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x1, w2
               	cmp	x1, x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sxth	x1, w6
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	mul	x1, x0, x17
               	cmp	x5, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	mul	x1, x0, x17
               	cmp	x5, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x60
               	mov	x2, #0x0                // =0
               	ldr	d0, [x1]
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x60
               	ldr	d0, [x1, #0x8]
               	scvtf	d1, x0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fdiv	d1, d1, d17
               	fcmp	d0, d1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x60
               	ldr	d0, [x1, #0x10]
               	scvtf	d1, x0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fdiv	d1, d1, d17
               	fcmp	d0, d1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x60
               	ldr	d0, [x1, #0x18]
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldr	s0, [x1]
               	scvtf	s1, x0
               	mov	x1, #0x40800000         // =1082130432
               	fmov	s17, w1
               	fdiv	s1, s1, s17
               	fcmp	s0, s1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x10
               	ldr	s0, [x1, #0x8]
               	scvtf	s1, x0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s1, s1, s17
               	fcmp	s0, s1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_deferred>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x3, x0
               	sxtw	x3, w3
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x5]
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldrb	w10, [x1, #0x40]
               	strb	w10, [x0, #0x40]
               	ldrb	w10, [x1, #0x41]
               	strb	w10, [x0, #0x41]
               	ldrb	w10, [x1, #0x42]
               	strb	w10, [x0, #0x42]
               	ldrb	w10, [x1, #0x43]
               	strb	w10, [x0, #0x43]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	w0, w3
               	sub	x1, x29, #0x48
               	str	w0, [x1]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x10]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x14]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x18]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x1c]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x24]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x28]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x2c]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x34]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x38]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x3c]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x40]
               	ldrsw	x0, [x5]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x48
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w4, w3
               	cmp	x2, x4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x11
               	b.lt	<addr>
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x70
               	str	w0, [x1]
               	sxtw	x0, w3
               	ldrsw	x1, [x5]
               	add	x1, x1, #0x1
               	str	w1, [x5]
               	sxtw	x4, w0
               	sub	x0, x29, #0x70
               	str	w3, [x0, #0x14]
               	sub	x0, x29, #0x70
               	mov	w2, w3
               	str	w2, [x0, #0x18]
               	mov	x1, #0x3                // =3
               	sub	x0, x29, #0x70
               	str	w1, [x0, #0x1c]
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sxtw	x0, w4
               	cmp	x0, x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sxtw	x0, w2
               	cmp	x0, x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
