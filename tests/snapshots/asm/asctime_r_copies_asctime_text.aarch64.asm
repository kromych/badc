
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
               	mov	x1, #0xd                // =13
               	movk	x1, #0xf, lsl #32
               	mov	x2, #0x4                // =4
               	movk	x2, #0xe, lsl #32
               	stur	x2, [x29, #-0x20]
               	stur	x1, [x29, #-0x30]
               	mov	x1, #0x5                // =5
               	movk	x1, #0x4, lsl #32
               	stur	x1, [x29, #-0x38]
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
               	mov	x0, #0x7878787878787878 // =8680820740569200760
               	stur	x0, [x29, #-0x58]
               	stur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x7878             // =30840
               	sturh	w0, [x29, #-0x40]
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
