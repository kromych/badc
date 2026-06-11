
libc_math_round.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3b0              // =944
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fneg	d0, d16
               	bl	<addr>
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x4003, lsl #48
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1000             // =4096
               	movk	x0, #0xd4a5, lsl #16
               	movk	x0, #0xe8, lsl #32
               	scvtf	d0, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	bl	<addr>
               	mov	x17, #0x1001            // =4097
               	movk	x17, #0xd4a5, lsl #16
               	movk	x17, #0xe8, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	x0, d0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	x0, d0
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
