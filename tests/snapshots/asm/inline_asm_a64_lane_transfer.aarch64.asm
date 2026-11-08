
inline_asm_a64_lane_transfer.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	mov	x16, #0x7               // =7
               	mov	x17, #0x2a              // =42
               	mov	v0.s[0], w16
               	mov	v0.s[2], w17
               	mov	w0, v0.s[2]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xee              // =238
               	dup	v0.16b, w16
               	smov	w0, v0.b[0]
               	mov	x17, #-0x12             // =-18
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x2               // =-2
               	sturh	w0, [x29, #-0x8]
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	ldur	q0, [x29, #-0x40]
               	str	q0, [sp, #0x10]
               	mov	x16, #0x3e8             // =1000
               	str	x16, [sp, #0x20]
               	ldr	q0, [sp, #0x10]
               	ldr	x0, [sp, #0x20]
               	mov	v0.s[3], w0
               	stur	q0, [x29, #-0x40]
               	ldur	q0, [x29, #-0x40]
               	str	q0, [sp, #0x10]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x20]
               	ldr	q0, [sp, #0x10]
               	ldr	x0, [sp, #0x20]
               	ld1	{ v0.h }[4], [x0]
               	stur	q0, [x29, #-0x40]
               	sub	x16, x29, #0x40
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x10]
               	ldr	q0, [x16]
               	mov	w0, v0.s[3]
               	ldursw	x1, [x29, #-0x38]
               	add	x0, x0, x1
               	mov	x17, #0x3e6             // =998
               	movk	x17, #0x1, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
