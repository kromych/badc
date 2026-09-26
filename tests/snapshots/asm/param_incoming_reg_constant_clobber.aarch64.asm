
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

<func_1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
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
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<func_10>:
               	mov	x3, #0x5                // =5
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
               	orr	x0, x0, x3
               	lsr	x3, x0, #2
               	lsl	x3, x3, #2
               	sub	x0, x0, x3
               	ldr	x1, [x1]
               	ldrh	w1, [x1]
               	sxth	x0, w0
               	sxth	x1, w1
               	cbz	w1, <addr>
               	mov	x17, #-0x8000           // =-32768
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x3]
               	cmp	w0, #0x5
               	b.gt	<addr>
               	ldrsw	x0, [x2]
               	str	w0, [x2]
               	ldrsw	x0, [x1]
               	cbnz	x0, <addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	ldrsw	x0, [x3]
               	cmp	w0, #0x5
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	ret
               	sdiv	x0, x0, x1
               	b	<addr>
               	lsl	x0, x0, #6
               	b	<addr>

<func_17>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
