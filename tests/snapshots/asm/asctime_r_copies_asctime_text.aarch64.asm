
asctime_r_copies_asctime_text.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x38
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	str	xzr, [x0, #0x30]
               	mov	x1, #0x46               // =70
               	stur	w1, [x29, #-0x24]
               	mov	x1, #0xf                // =15
               	stur	w1, [x29, #-0x2c]
               	mov	x1, #0x4                // =4
               	stur	w1, [x29, #-0x20]
               	mov	x2, #0xe                // =14
               	stur	w2, [x29, #-0x1c]
               	mov	x2, #0xd                // =13
               	stur	w2, [x29, #-0x30]
               	stur	w1, [x29, #-0x34]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x38]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	blr	x1
               	cbz	x0, <addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x58
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0x58]
               	sturb	w0, [x29, #-0x57]
               	sturb	w0, [x29, #-0x56]
               	sturb	w0, [x29, #-0x55]
               	sturb	w0, [x29, #-0x54]
               	sturb	w0, [x29, #-0x53]
               	sturb	w0, [x29, #-0x52]
               	sturb	w0, [x29, #-0x51]
               	sturb	w0, [x29, #-0x50]
               	sturb	w0, [x29, #-0x4f]
               	sturb	w0, [x29, #-0x4e]
               	sturb	w0, [x29, #-0x4d]
               	sturb	w0, [x29, #-0x4c]
               	sturb	w0, [x29, #-0x4b]
               	sturb	w0, [x29, #-0x4a]
               	sturb	w0, [x29, #-0x49]
               	sturb	w0, [x29, #-0x48]
               	sturb	w0, [x29, #-0x47]
               	sturb	w0, [x29, #-0x46]
               	sturb	w0, [x29, #-0x45]
               	sturb	w0, [x29, #-0x44]
               	sturb	w0, [x29, #-0x43]
               	sturb	w0, [x29, #-0x42]
               	sturb	w0, [x29, #-0x41]
               	sturb	w0, [x29, #-0x40]
               	sturb	w0, [x29, #-0x3f]
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x58
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0xb                // =11
               	stur	w1, [x29, #-0x28]
               	mov	x1, #0x1f               // =31
               	stur	w1, [x29, #-0x2c]
               	sub	x1, x29, #0x58
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
