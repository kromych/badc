
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrh	w1, [x1]
               	sxtb	x1, w1
               	cmp	w1, #0x0
               	b.lt	<addr>
               	cmp	w1, #0x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	orr	x1, x1, x3
               	lsr	x3, x1, #2
               	lsl	x3, x3, #2
               	sub	x1, x1, x3
               	ldr	x0, [x0]
               	ldrh	w0, [x0]
               	sxth	x1, w1
               	sxth	x0, w0
               	cbz	w0, <addr>
               	mov	x17, #-0x8000           // =-32768
               	cmp	w1, w17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
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
