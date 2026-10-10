
call_result_into_member.aarch64:	file format elf64-littleaarch64

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

<keep>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	ret

<mk_U1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	strb	wzr, [x0]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	mov	x16, x0
               	ldrb	w0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_U2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	strh	wzr, [x0]
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x8]
               	mov	x16, x0
               	ldrh	w0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_U3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	strh	wzr, [x0]
               	strb	wzr, [x0, #0x2]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x7]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x6]
               	mov	x16, x0
               	ldrh	w0, [x16]
               	ldrb	w17, [x16, #0x2]
               	lsl	x17, x17, #16
               	orr	x0, x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_B4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	str	wzr, [x0]
               	and	x1, x1, #0xfffff
               	stur	w1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	and	x1, x1, #0xffffffffc00fffff
               	orr	x1, x1, #0x3ff00000
               	stur	w1, [x29, #-0x8]
               	mov	x16, x0
               	ldr	w0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_U5>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	str	wzr, [x0]
               	strb	wzr, [x0, #0x4]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x7]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x6]
               	mov	x1, #0x4                // =4
               	sturb	w1, [x29, #-0x5]
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0x4]
               	mov	x16, x0
               	ldr	w0, [x16]
               	ldrb	w17, [x16, #0x4]
               	lsl	x17, x17, #32
               	orr	x0, x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_U6>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	str	wzr, [x0]
               	strh	wzr, [x0, #0x4]
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sturh	w1, [x29, #-0x6]
               	mov	x1, #0x3                // =3
               	sturh	w1, [x29, #-0x4]
               	mov	x16, x0
               	ldr	w0, [x16]
               	ldrh	w17, [x16, #0x4]
               	lsl	x17, x17, #32
               	orr	x0, x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_U7>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	str	wzr, [x0]
               	strh	wzr, [x0, #0x4]
               	strb	wzr, [x0, #0x6]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x7]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x6]
               	mov	x1, #0x4                // =4
               	sturb	w1, [x29, #-0x5]
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0x4]
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x3]
               	mov	x1, #0x7                // =7
               	sturb	w1, [x29, #-0x2]
               	mov	x16, x0
               	ldr	w0, [x16]
               	ldrh	w17, [x16, #0x4]
               	lsl	x17, x17, #32
               	orr	x0, x0, x17
               	ldrb	w17, [x16, #0x6]
               	lsl	x17, x17, #48
               	orr	x0, x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_U12>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0xc]
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x8]
               	mov	x16, x0
               	ldr	w1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_F3>:
               	sxtw	x0, w0
               	scvtf	s0, x0
               	fmov	s1, #2.00000000
               	fmov	s2, #3.00000000
               	ret

<mk_FI>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x1, w0
               	sub	x0, x29, #0x10
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	scvtf	s0, x1
               	stur	s0, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0xc]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x8]
               	mov	x16, x0
               	ldr	w1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<local_U1>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x7]
               	mov	x0, x20
               	bl	<addr>
               	sturb	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_U1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x0, x1
               	bl	<addr>
               	sturb	w0, [x29, #-0x38]
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_U1>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x5f]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, x20
               	sub	x8, x29, #0x60
               	bl	<addr>
               	ldurb	w0, [x29, #-0x60]
               	ldurb	w1, [x29, #-0x5f]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret

<local_U2>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x6]
               	mov	x0, x20
               	bl	<addr>
               	sturh	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldurh	w0, [x29, #-0x8]
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_U2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x0, x1
               	bl	<addr>
               	sturh	w0, [x29, #-0x38]
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_U2>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x5e]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, x20
               	sub	x8, x29, #0x60
               	bl	<addr>
               	ldurh	w0, [x29, #-0x60]
               	ldurb	w1, [x29, #-0x5e]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret

<local_U3>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x5]
               	mov	x0, x20
               	bl	<addr>
               	sturh	w0, [x29, #-0x8]
               	lsr	x0, x0, #16
               	sturb	w0, [x29, #-0x6]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_U3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x0, x1
               	bl	<addr>
               	sturh	w0, [x29, #-0x38]
               	lsr	x0, x0, #16
               	sturb	w0, [x29, #-0x36]
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_U3>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x5d]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, x20
               	sub	x8, x29, #0x60
               	bl	<addr>
               	ldurb	w0, [x29, #-0x60]
               	ldurb	w1, [x29, #-0x5d]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret

<local_B4>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x4]
               	mov	x0, x20
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffff
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_B4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x0, x1
               	bl	<addr>
               	stur	w0, [x29, #-0x38]
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_B4>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x5c]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, x20
               	sub	x8, x29, #0x60
               	bl	<addr>
               	ldur	w0, [x29, #-0x60]
               	ldurb	w1, [x29, #-0x5c]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	and	x0, x0, #0xfffff
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret

<local_U5>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x3]
               	mov	x0, x20
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	lsr	x0, x0, #32
               	sturb	w0, [x29, #-0x4]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x5]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_U5>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x0, x1
               	bl	<addr>
               	stur	w0, [x29, #-0x38]
               	lsr	x0, x0, #32
               	sturb	w0, [x29, #-0x34]
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_U5>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x5b]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, x20
               	sub	x8, x29, #0x60
               	bl	<addr>
               	ldurb	w0, [x29, #-0x60]
               	ldurb	w1, [x29, #-0x5b]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret

<local_U6>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x2]
               	mov	x0, x20
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	lsr	x0, x0, #32
               	sturh	w0, [x29, #-0x4]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x6]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldurh	w0, [x29, #-0x8]
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_U6>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x0, x1
               	bl	<addr>
               	stur	w0, [x29, #-0x38]
               	lsr	x0, x0, #32
               	sturh	w0, [x29, #-0x34]
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_U6>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x5a]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, x20
               	sub	x8, x29, #0x60
               	bl	<addr>
               	ldurh	w0, [x29, #-0x60]
               	ldurb	w1, [x29, #-0x5a]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret

<local_U7>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x1]
               	mov	x0, x20
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	lsr	x0, x0, #32
               	sturh	w0, [x29, #-0x4]
               	lsr	x0, x0, #16
               	sturb	w0, [x29, #-0x2]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_U7>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x0, x1
               	bl	<addr>
               	stur	w0, [x29, #-0x38]
               	lsr	x0, x0, #32
               	sturh	w0, [x29, #-0x34]
               	lsr	x0, x0, #16
               	sturb	w0, [x29, #-0x32]
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_U7>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x59]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, x20
               	sub	x8, x29, #0x60
               	bl	<addr>
               	ldurb	w0, [x29, #-0x60]
               	ldurb	w1, [x29, #-0x59]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret

<local_U12>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x4]
               	mov	x0, x20
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	w1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_U12>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x40
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldr	x16, [x2, #0x30]
               	str	x16, [x0, #0x30]
               	mov	x0, x1
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	stur	w1, [x29, #-0x38]
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldr	x0, [x16, #0x30]
               	str	x0, [x17, #0x30]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_U12>:
               	str	x20, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x20, x0
               	sub	x1, x29, #0x70
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	str	xzr, [x1, #0x30]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x64]
               	sub	x0, x29, #0x38
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldr	x16, [x1, #0x30]
               	str	x16, [x0, #0x30]
               	mov	x1, x20
               	sub	x8, x29, #0x70
               	bl	<addr>
               	ldur	w0, [x29, #-0x70]
               	ldurb	w1, [x29, #-0x64]
               	mov	x17, #0x55              // =85
               	eor	x2, x1, x17
               	mov	x1, #0x0                // =0
               	cbnz	w2, <addr>
               	cmp	w0, w20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret

<local_F3>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sxtw	x20, w0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x4]
               	mov	x0, x20
               	bl	<addr>
               	stur	s0, [x29, #-0x10]
               	stur	s1, [x29, #-0xc]
               	stur	s2, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldur	s0, [x29, #-0x10]
               	fcvtzs	x0, s0
               	cmp	x0, x20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_F3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x70]
               	sub	x0, x29, #0x40
               	ldur	x2, [x29, #-0x70]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldr	x16, [x2, #0x30]
               	str	x16, [x0, #0x30]
               	mov	x0, x1
               	bl	<addr>
               	stur	s0, [x29, #-0x50]
               	sub	x0, x29, #0x50
               	stur	s1, [x29, #-0x4c]
               	stur	s2, [x29, #-0x48]
               	sub	x1, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	w16, [x0, #0x8]
               	str	w16, [x1, #0x8]
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldr	x0, [x16, #0x30]
               	str	x0, [x17, #0x30]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_F3>:
               	str	x20, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sxtw	x20, w0
               	sub	x1, x29, #0x70
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	str	xzr, [x1, #0x30]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x64]
               	sub	x0, x29, #0x38
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldr	x16, [x1, #0x30]
               	str	x16, [x0, #0x30]
               	mov	x1, x20
               	sub	x8, x29, #0x70
               	bl	<addr>
               	ldurb	w0, [x29, #-0x64]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldur	s0, [x29, #-0x70]
               	fcvtzs	x0, s0
               	cmp	x0, x20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret

<local_FI>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sxtw	x20, w0
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x4]
               	mov	x0, x20
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	w1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldur	s0, [x29, #-0x10]
               	fcvtzs	x0, s0
               	cmp	x0, x20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<param_FI>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x40
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldr	x16, [x2, #0x30]
               	str	x16, [x0, #0x30]
               	mov	x0, x1
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	stur	w1, [x29, #-0x38]
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldr	x0, [x16, #0x30]
               	str	x0, [x17, #0x30]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_param_FI>:
               	str	x20, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sxtw	x20, w0
               	sub	x1, x29, #0x70
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	str	xzr, [x1, #0x30]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x64]
               	sub	x0, x29, #0x38
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldr	x16, [x1, #0x30]
               	str	x16, [x0, #0x30]
               	mov	x1, x20
               	sub	x8, x29, #0x70
               	bl	<addr>
               	ldurb	w0, [x29, #-0x64]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	ldur	s0, [x29, #-0x70]
               	fcvtzs	x0, s0
               	cmp	x0, x20
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	sub	x0, x29, #0xa0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	stp	xzr, xzr, [x0, #0x60]
               	stp	xzr, xzr, [x0, #0x70]
               	stp	xzr, xzr, [x0, #0x80]
               	stp	xzr, xzr, [x0, #0x90]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0xa0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x98]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x90]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x88]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x80]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x78]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x70]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x68]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x58]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x50]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x48]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x40]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x38]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x30]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x28]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x20]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	sub	x21, x29, #0xa0
               	stur	x0, [x29, #-0x8]
               	mov	x20, #0x0               // =0
               	ldr	x1, [x21, x20, lsl #3]
               	mov	x0, #0x27               // =39
               	blr	x1
               	cbz	w0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x14
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
