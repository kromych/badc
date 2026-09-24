
param_incoming_reg_constant_clobber.aarch64:	file format elf64-littleaarch64

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

<func_10>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldrh	w0, [x0]
               	sxtb	x0, w0
               	cmp	w0, #0x0
               	b.lt	<addr>
               	cmp	w0, #0x1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #0x5               // =5
               	orr	x0, x0, x17
               	mov	w0, w0
               	lsr	x3, x0, #2
               	lsl	x3, x3, #2
               	sub	x0, x0, x3
               	sxth	x0, w0
               	ldr	x1, [x1]
               	ldrh	w1, [x1]
               	sxth	x1, w1
               	cbz	w1, <addr>
               	mov	x17, #-0x8000           // =-32768
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w0, [x3]
               	cmp	w0, #0x5
               	b.hi	<addr>
               	ldrsw	x0, [x2]
               	str	w0, [x2]
               	ldrsw	x0, [x1]
               	cbnz	x0, <addr>
               	ldr	w0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	ldr	w0, [x3]
               	cmp	w0, #0x5
               	b.ls	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, x0
               	ldr	x0, [x16]
               	ret
               	sdiv	x0, x0, x1
               	sxth	x0, w0
               	b	<addr>
               	lsl	x0, x0, #6
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x5                // =5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	mov	x4, x1
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	eor	x0, x0, #0x6
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
