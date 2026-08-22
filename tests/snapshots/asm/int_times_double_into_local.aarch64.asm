
int_times_double_into_local.aarch64:	file format elf64-littleaarch64

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

<compute>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x1, w1
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	mov	x0, #-0x4000000000000000 // =-4611686018427387904
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	fmov	d16, x0
               	fmul	d0, d16, d0
               	scvtf	d1, x1
               	fmul	d0, d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x8               // =8
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fneg	d1, d16
               	mov	x22, #0x2d18            // =11544
               	movk	x22, #0x5444, lsl #16
               	movk	x22, #0x21fb, lsl #32
               	movk	x22, #0x4009, lsl #48
               	fmov	d17, x22
               	fmul	d1, d1, d17
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fneg	d1, d16
               	fmov	d17, x22
               	fmul	d1, d1, d17
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
