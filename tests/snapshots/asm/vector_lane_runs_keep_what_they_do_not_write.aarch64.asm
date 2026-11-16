
vector_lane_runs_keep_what_they_do_not_write.aarch64:	file format elf64-littleaarch64

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

<partial>:
               	mov	v0.s[1], w0
               	mov	v0.s[3], w0
               	ret

<read_between>:
               	st1	{ v0.s }[2], [x1]
               	dup	v0.4s, w0
               	ret

<full>:
               	fmov	s0, w0
               	mov	v0.s[1], w1
               	mov	v0.s[2], w2
               	mov	v0.s[3], w3
               	ret

<bytes>:
               	ld1	{ v0.b }[0], [x0]
               	ldrb	w1, [x0, #0x1]
               	mov	v0.b[1], w1
               	ldrb	w1, [x0, #0x2]
               	mov	v0.b[2], w1
               	ldrb	w1, [x0, #0x3]
               	mov	v0.b[3], w1
               	ldrb	w1, [x0, #0x4]
               	mov	v0.b[4], w1
               	ldrb	w1, [x0, #0x5]
               	mov	v0.b[5], w1
               	ldrb	w1, [x0, #0x6]
               	mov	v0.b[6], w1
               	ldrb	w1, [x0, #0x7]
               	mov	v0.b[7], w1
               	ldrb	w1, [x0, #0x8]
               	mov	v0.b[8], w1
               	ldrb	w1, [x0, #0x9]
               	mov	v0.b[9], w1
               	ldrb	w1, [x0, #0xa]
               	mov	v0.b[10], w1
               	ldrb	w1, [x0, #0xb]
               	mov	v0.b[11], w1
               	ldrb	w1, [x0, #0xc]
               	mov	v0.b[12], w1
               	ldrb	w1, [x0, #0xd]
               	mov	v0.b[13], w1
               	ldrb	w1, [x0, #0xe]
               	mov	v0.b[14], w1
               	ldrb	w0, [x0, #0xf]
               	mov	v0.b[15], w0
               	ret

<dirty>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x200
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x200
               	add	x1, x1, x0, lsl #3
               	mov	x2, #-0x1               // =-1
               	str	x2, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret

<pointer_member>:
               	mov	x0, #0x0                // =0
               	ret

<put2>:
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ret

<put3>:
               	mov	w1, w1
               	str	x1, [x0]
               	str	wzr, [x0, #0x8]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	sub	x7, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldursw	x0, [x29, #-0x8]
               	ldr	q0, [x7]
               	bl	<addr>
               	smov	x0, v0.s[0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	cmp	x0, #0x1e
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x38]
               	sub	x7, x29, #0x50
               	ldursw	x0, [x29, #-0x8]
               	sub	x1, x29, #0x38
               	ldr	q0, [x7]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x1e
               	b.ne	<addr>
               	smov	x0, v0.s[0]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x2
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x3, #0x3
               	bl	<addr>
               	smov	x0, v0.s[0]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x8
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0xd                // =13
               	sub	x2, x29, #0x28
               	mul	x3, x0, x1
               	ldursw	x4, [x29, #-0x8]
               	add	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x28
               	bl	<addr>
               	umov	w0, v0.b[0]
               	ldurb	w1, [x29, #-0x28]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	umov	w0, v0.b[1]
               	ldurb	w1, [x29, #-0x27]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[2]
               	ldurb	w1, [x29, #-0x26]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[3]
               	ldurb	w1, [x29, #-0x25]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[4]
               	ldurb	w1, [x29, #-0x24]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[5]
               	ldurb	w1, [x29, #-0x23]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[6]
               	ldurb	w1, [x29, #-0x22]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[7]
               	ldurb	w1, [x29, #-0x21]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[8]
               	ldurb	w1, [x29, #-0x20]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[9]
               	ldurb	w1, [x29, #-0x1f]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[10]
               	ldurb	w1, [x29, #-0x1e]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[11]
               	ldurb	w1, [x29, #-0x1d]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[12]
               	ldurb	w1, [x29, #-0x1c]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[13]
               	ldurb	w1, [x29, #-0x1b]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[14]
               	ldurb	w1, [x29, #-0x1a]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[15]
               	ldurb	w1, [x29, #-0x19]
               	cmp	x0, x1
               	b.ne	<addr>
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldursw	x1, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	neg	x2, x2
               	bl	<addr>
               	ldursw	x0, [x29, #-0x30]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x2c]
               	cmn	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x14]
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x10]
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
