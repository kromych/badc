
runtime_range_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
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
               	sub	sp, sp, #0x40
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	sub	x1, x29, #0x18
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x18
               	ldr	w2, [x1, #0x4]
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x18
               	ldr	w2, [x1, #0x4]
               	str	w2, [x1, #0xc]
               	mov	x2, #0x2a               // =42
               	sub	x1, x29, #0x18
               	str	w2, [x1, #0x10]
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
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0xc]
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_override>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sxtw	x0, w0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x2]
               	sub	x1, x29, #0x18
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldrb	w10, [x3, #0x10]
               	strb	w10, [x1, #0x10]
               	ldrb	w10, [x3, #0x11]
               	strb	w10, [x1, #0x11]
               	ldrb	w10, [x3, #0x12]
               	strb	w10, [x1, #0x12]
               	ldrb	w10, [x3, #0x13]
               	strb	w10, [x1, #0x13]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	add	x4, x4, #0x1
               	str	w4, [x1]
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x1, x29, #0x18
               	ldr	w3, [x1]
               	str	w3, [x1, #0x4]
               	sub	x1, x29, #0x18
               	ldr	w3, [x1]
               	str	w3, [x1, #0x8]
               	sub	x1, x29, #0x18
               	ldr	w3, [x1]
               	str	w3, [x1, #0xc]
               	sub	x1, x29, #0x18
               	ldr	w3, [x1]
               	str	w3, [x1, #0x10]
               	add	x1, x0, #0x7
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x5, [x3]
               	add	x5, x5, #0x1
               	str	w5, [x3]
               	sub	x3, x29, #0x18
               	str	w1, [x3, #0x8]
               	ldrsw	x1, [x2]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0xc]
               	cmp	x1, x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x10]
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1, #0x8]
               	add	x1, x0, #0x7
               	sxtw	x1, w1
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x30
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
               	sub	x1, x29, #0x30
               	str	w0, [x1]
               	sub	x1, x29, #0x30
               	ldr	w2, [x1]
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x30
               	ldr	w2, [x1]
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x30
               	ldr	w2, [x1]
               	str	w2, [x1, #0xc]
               	add	x1, x0, #0x1
               	sub	x2, x29, #0x30
               	str	w1, [x2, #0x8]
               	sub	x1, x29, #0x30
               	ldr	w2, [x1, #0x8]
               	str	w2, [x1, #0xc]
               	sub	x1, x29, #0x30
               	ldr	w2, [x1, #0x8]
               	str	w2, [x1, #0x10]
               	sub	x1, x29, #0x30
               	ldr	w2, [x1, #0x8]
               	str	w2, [x1, #0x14]
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1]
               	cmp	x1, x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x30
               	ldrsw	x2, [x1, #0x8]
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	cmp	x2, x1
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x30
               	ldrsw	x2, [x1, #0xc]
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	cmp	x2, x1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1, #0x14]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
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
               	sub	sp, sp, #0xe0
               	sxtw	x0, w0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
               	sub	x1, x29, #0x8
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
               	sub	x1, x29, #0x8
               	strb	w2, [x1, #0x2]
               	sub	x1, x29, #0x8
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x1, #0x3]
               	sub	x1, x29, #0x8
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x1, #0x4]
               	sub	x1, x29, #0x8
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x1, #0x5]
               	sub	x1, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x1, #0x9]
               	ldr	x10, [sp], #0x10
               	sxtw	x2, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	add	x4, x4, #0x1
               	str	w4, [x1]
               	sxtw	x1, w2
               	sub	x2, x29, #0x18
               	strh	w1, [x2]
               	sub	x1, x29, #0x18
               	ldrh	w2, [x1]
               	strh	w2, [x1, #0x2]
               	sub	x1, x29, #0x18
               	ldrh	w2, [x1]
               	strh	w2, [x1, #0x4]
               	sub	x1, x29, #0x18
               	ldrh	w2, [x1]
               	strh	w2, [x1, #0x6]
               	sub	x1, x29, #0x18
               	ldrh	w2, [x1]
               	strh	w2, [x1, #0x8]
               	sub	x1, x29, #0x30
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
               	ldrsw	x4, [x1]
               	add	x4, x4, #0x1
               	str	w4, [x1]
               	sxtw	x2, w2
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	mul	x1, x2, x17
               	sub	x4, x29, #0x30
               	str	x1, [x4]
               	sub	x1, x29, #0x30
               	ldr	x4, [x1]
               	str	x4, [x1, #0x8]
               	sub	x1, x29, #0x30
               	ldr	x4, [x1]
               	str	x4, [x1, #0x10]
               	sub	x1, x29, #0x50
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x1]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x4, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x4, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x5, [x1]
               	add	x5, x5, #0x1
               	str	w5, [x1]
               	scvtf	d0, x2
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fdiv	d0, d0, d17
               	sub	x1, x29, #0x50
               	str	d0, [x1, #0x8]
               	sub	x1, x29, #0x50
               	ldr	x4, [x1, #0x8]
               	str	x4, [x1, #0x10]
               	sub	x1, x29, #0x68
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x1]
               	ldrb	w10, [x4, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x4, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x4, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x4, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x5, [x1]
               	add	x5, x5, #0x1
               	str	w5, [x1]
               	scvtf	s0, x2
               	mov	x1, #0x40800000         // =1082130432
               	fmov	s17, w1
               	fdiv	s0, s0, s17
               	sub	x1, x29, #0x68
               	str	s0, [x1]
               	sub	x1, x29, #0x68
               	ldr	w2, [x1]
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x68
               	ldr	w2, [x1]
               	str	w2, [x1, #0x8]
               	ldrsw	x1, [x3]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1, #0x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1, #0x2]
               	mov	x17, #0x41              // =65
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1, #0x5]
               	mov	x17, #0x41              // =65
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1, #0x6]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	ldrsh	x1, [x1]
               	cmp	x1, x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrsh	x1, [x1, #0x8]
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x30
               	ldr	x1, [x1]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	mul	x2, x0, x17
               	cmp	x1, x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x30
               	ldr	x1, [x1, #0x10]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	mul	x2, x0, x17
               	cmp	x1, x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	mov	x2, #0x0                // =0
               	ldr	d0, [x1]
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x50
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
               	sub	x1, x29, #0x50
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
               	sub	x1, x29, #0x50
               	ldr	d0, [x1, #0x18]
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x68
               	ldr	s0, [x1]
               	scvtf	s1, x0
               	mov	x1, #0x40800000         // =1082130432
               	fmov	s17, w1
               	fdiv	s1, s1, s17
               	fcmp	s0, s1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x68
               	ldr	s0, [x1, #0x8]
               	scvtf	s1, x0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s1, s1, s17
               	fcmp	s0, s1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
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
               	sub	sp, sp, #0xa0
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
               	add	sp, sp, #0xa0
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
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x70
               	str	w1, [x0]
               	ldrsw	x2, [x5]
               	add	x2, x2, #0x1
               	str	w2, [x5]
               	sub	x0, x29, #0x70
               	str	w3, [x0, #0x14]
               	sub	x0, x29, #0x70
               	ldr	w2, [x0, #0x14]
               	str	w2, [x0, #0x18]
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0x70
               	str	w2, [x0, #0x1c]
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x1c]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xa0
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
