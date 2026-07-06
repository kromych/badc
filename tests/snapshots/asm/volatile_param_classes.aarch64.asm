
volatile_param_classes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #0x10]
               	str	d0, [x29, #0x20]
               	ldur	x0, [x29, #0x10]
               	ldr	d0, [x0]
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	ldur	x0, [x29, #0x10]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	ldr	d1, [x29, #0x20]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<half>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<bump>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x8]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x1
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x1
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x1
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldr	d0, [x0]
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x20, ne
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
