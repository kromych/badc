
vector_shufflevector_takes_the_indexed_lanes.aarch64:	file format elf64-littleaarch64

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

<zip>:
               	umov	w0, v0.b[0]
               	mov	v2.b[0], w0
               	umov	w0, v1.b[0]
               	mov	v2.b[1], w0
               	umov	w0, v0.b[1]
               	mov	v2.b[2], w0
               	umov	w0, v1.b[1]
               	mov	v2.b[3], w0
               	umov	w0, v0.b[2]
               	mov	v2.b[4], w0
               	umov	w0, v1.b[2]
               	mov	v2.b[5], w0
               	umov	w0, v0.b[3]
               	mov	v2.b[6], w0
               	umov	w0, v1.b[3]
               	mov	v2.b[7], w0
               	umov	w0, v0.b[4]
               	mov	v2.b[8], w0
               	umov	w0, v1.b[4]
               	mov	v2.b[9], w0
               	umov	w0, v0.b[5]
               	mov	v2.b[10], w0
               	umov	w0, v1.b[5]
               	mov	v2.b[11], w0
               	umov	w0, v0.b[6]
               	mov	v2.b[12], w0
               	umov	w0, v1.b[6]
               	mov	v2.b[13], w0
               	umov	w0, v0.b[7]
               	mov	v0.16b, v2.16b
               	mov	v0.b[14], w0
               	umov	w0, v1.b[7]
               	mov	v0.b[15], w0
               	ret

<rev>:
               	mov	w0, v0.s[3]
               	fmov	s1, w0
               	mov	w0, v0.s[2]
               	mov	v1.s[1], w0
               	mov	w0, v0.s[1]
               	mov	v1.s[2], w0
               	mov	w0, v0.s[0]
               	mov	v0.16b, v1.16b
               	mov	v0.s[3], w0
               	ret

<cat>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	mov	w1, v0.s[0]
               	stur	w1, [x29, #-0x30]
               	mov	w1, v0.s[1]
               	stur	w1, [x29, #-0x2c]
               	mov	w1, v0.s[2]
               	stur	w1, [x29, #-0x28]
               	mov	w1, v0.s[3]
               	stur	w1, [x29, #-0x24]
               	mov	w1, v1.s[0]
               	stur	w1, [x29, #-0x20]
               	mov	w1, v1.s[1]
               	stur	w1, [x29, #-0x1c]
               	mov	w1, v1.s[2]
               	stur	w1, [x29, #-0x18]
               	mov	w1, v1.s[3]
               	stur	w1, [x29, #-0x14]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<lo>:
               	mov	w0, v1.s[3]
               	fmov	s1, w0
               	mov	w0, v0.s[0]
               	mov	v0.16b, v1.16b
               	mov	v0.s[1], w0
               	ret

<fsh>:
               	mov	w0, v1.s[0]
               	fmov	s2, w0
               	mov	w0, v0.s[2]
               	mov	v0.16b, v2.16b
               	mov	v0.s[2], w0
               	mov	w0, v1.s[1]
               	mov	v0.s[3], w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	mov	x0, #0x100              // =256
               	mov	x1, #0x6564             // =25956
               	sturh	w0, [x29, #-0x60]
               	sturh	w1, [x29, #-0x50]
               	mov	x0, #0x302              // =770
               	mov	x1, #0x6766             // =26470
               	sturh	w0, [x29, #-0x5e]
               	sturh	w1, [x29, #-0x4e]
               	mov	x0, #0x504              // =1284
               	mov	x1, #0x6968             // =26984
               	sturh	w0, [x29, #-0x5c]
               	sturh	w1, [x29, #-0x4c]
               	mov	x0, #0x706              // =1798
               	mov	x1, #0x6b6a             // =27498
               	sturh	w0, [x29, #-0x5a]
               	sturh	w1, [x29, #-0x4a]
               	mov	x0, #0x908              // =2312
               	mov	x1, #0x6d6c             // =28012
               	sturh	w0, [x29, #-0x58]
               	sturh	w1, [x29, #-0x48]
               	mov	x0, #0xb0a              // =2826
               	sub	x7, x29, #0x50
               	mov	x1, #0x6f6e             // =28526
               	sub	x2, x29, #0x60
               	sturh	w0, [x29, #-0x56]
               	sturh	w1, [x29, #-0x46]
               	mov	x0, #0xd0c              // =3340
               	mov	x1, #0x7170             // =29040
               	sturh	w0, [x29, #-0x54]
               	sturh	w1, [x29, #-0x44]
               	mov	x0, #0xf0e              // =3854
               	mov	x1, #0x7372             // =29554
               	sturh	w0, [x29, #-0x52]
               	sturh	w1, [x29, #-0x42]
               	ldr	q0, [x2]
               	ldr	q1, [x7]
               	bl	<addr>
               	umov	w0, v0.b[0]
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[1]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[2]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[3]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[4]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[5]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[6]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[7]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[8]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[9]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[10]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[11]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[12]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[13]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[14]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	umov	w1, v0.b[15]
               	add	x20, x0, x1
               	sub	x7, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	v1.16b, v0.16b
               	sub	x7, x29, #0x30
               	sub	x0, x29, #0x60
               	str	q1, [sp, #0x90]
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	sub	x8, x29, #0x50
               	bl	<addr>
               	ldr	q1, [sp, #0x90]
               	ldur	w21, [x29, #-0x50]
               	ldur	w22, [x29, #-0x4c]
               	ldur	w23, [x29, #-0x48]
               	ldur	w24, [x29, #-0x44]
               	ldur	w25, [x29, #-0x40]
               	ldur	w26, [x29, #-0x3c]
               	ldur	w27, [x29, #-0x38]
               	ldur	w28, [x29, #-0x34]
               	sub	x7, x29, #0x30
               	sub	x0, x29, #0x60
               	str	q1, [sp, #0x90]
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	ldr	q1, [sp, #0x90]
               	mov	x17, #0x1f              // =31
               	mul	x0, x20, x17
               	smov	x1, v1.s[0]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	smov	x1, v1.s[1]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	smov	x1, v1.s[2]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	smov	x1, v1.s[3]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x21
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x22
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x23
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x24
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x25
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x26
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x27
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	add	x0, x0, x28
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	smov	x1, v0.s[0]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	smov	x1, v0.s[1]
               	add	x20, x0, x1
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	fmov	s0, #1.50000000
               	sub	x7, x29, #0x60
               	stur	s0, [x29, #-0x60]
               	ldur	s0, [x29, #-0x8]
               	stur	s0, [x29, #-0x5c]
               	fmov	s1, #3.50000000
               	stur	s1, [x29, #-0x58]
               	fmov	s1, #4.50000000
               	stur	s1, [x29, #-0x54]
               	sub	x0, x29, #0x50
               	stur	s0, [x29, #-0x50]
               	fmov	s0, #-2.00000000
               	stur	s0, [x29, #-0x4c]
               	stur	wzr, [x29, #-0x48]
               	fmov	s0, #9.00000000
               	stur	s0, [x29, #-0x44]
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	mov	x17, #0x1f              // =31
               	mul	x0, x20, x17
               	mov	w1, v0.s[0]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	mov	w1, v0.s[2]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	mov	w1, v0.s[3]
               	add	x0, x0, x1
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	mov	x17, #0xf746            // =63302
               	movk	x17, #0xcd89, lsl #16
               	cmp	w0, w17
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret
