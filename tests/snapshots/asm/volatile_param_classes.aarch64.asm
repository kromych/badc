
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

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x10
               	mov	x20, #0x0               // =0
               	str	x20, [x0]
               	str	x20, [x0, #0x8]
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	mov	x2, #0x1                // =1
               	str	x2, [x0, #0x8]
               	fmov	d16, x1
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	ldr	d0, [x0]
               	sub	x17, x29, #0x20
               	str	d0, [x17]
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	mov	x21, #0x4004000000000000 // =4612811918334230528
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x8]
               	fmov	d16, x21
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	ldr	d0, [x0]
               	sub	x17, x29, #0x20
               	str	d0, [x17]
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	mov	x1, #0x400c000000000000 // =4615063718147915776
               	ldr	x3, [x0, #0x8]
               	add	x3, x3, #0x1
               	str	x3, [x0, #0x8]
               	fmov	d16, x1
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	ldr	d0, [x0]
               	sub	x17, x29, #0x20
               	str	d0, [x17]
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x0]
               	mov	x1, #0x401e000000000000 // =4620130267728707584
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, x2
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	b	<addr>
