
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x21, #0x0               // =0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w0, [x20]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x17, #0x1               // =1
               	orr	x21, x21, x17
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	sxtw	x0, w21
               	mov	x17, #0x2               // =2
               	orr	x21, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w21
               	mov	x17, #0x4               // =4
               	orr	x21, x0, x17
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	add	x0, x0, x1
               	ldrsb	x0, [x0]
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x2, x1
               	ldrsb	x1, [x1]
               	eor	x0, x0, x1
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w21
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w21
               	mov	x17, #0x8               // =8
               	orr	x21, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
