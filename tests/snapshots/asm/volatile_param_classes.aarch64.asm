
volatile_param_classes.aarch64:	file format elf64-littleaarch64

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

<half>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	fcvt	d0, s0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	fmov	d16, x2
               	stur	d16, [x29, #-0x18]
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	ldr	x3, [x0, #0x8]
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x8]
               	fmov	d16, x2
               	stur	d16, [x29, #-0x18]
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	mov	x2, #0x400c000000000000 // =4615063718147915776
               	ldr	x3, [x0, #0x8]
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x8]
               	fmov	d16, x2
               	stur	d16, [x29, #-0x18]
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x0]
               	mov	x2, #0x401e000000000000 // =4620130267728707584
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
