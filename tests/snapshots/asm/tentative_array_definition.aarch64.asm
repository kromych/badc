
tentative_array_definition.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x2, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x17, #0x1               // =1
               	orr	x2, x2, x17
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x17, #0x2               // =2
               	orr	x2, x2, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x17, #0x4               // =4
               	orr	x2, x2, x17
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x3, w1
               	add	x0, x0, x3
               	ldrsb	x0, [x0]
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x3, w1
               	add	x0, x0, x3
               	ldrb	w0, [x0]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x3, x4, x3
               	ldrsb	x3, [x3]
               	eor	x0, x0, x3
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x17, #0x8               // =8
               	orr	x2, x2, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
