
int_times_double_into_local.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sxtw	x1, w1
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	mov	x0, #-0x4000000000000000 // =-4611686018427387904
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fmov	d16, x0
               	fmul	d0, d16, d0
               	scvtf	d1, x1
               	fmul	d0, d0, d1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x8                // =8
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x8                // =8
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fneg	d1, d16
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	fmov	d17, x0
               	fmul	d1, d1, d17
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x8                // =8
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fneg	d1, d16
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	fmov	d17, x0
               	fmul	d1, d1, d17
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
