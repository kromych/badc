
preinc_narrow_lvalue_wraps.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, x1
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, x1
               	mov	x0, #0x1                // =1
               	mov	x2, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x1, #0xff               // =255
               	sturb	w1, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldrb	w3, [x1]
               	add	x3, x3, #0x1
               	strb	w3, [x1]
               	ldrb	w1, [x1]
               	cbnz	x1, <addr>
               	mov	x1, x0
               	cmp	w1, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w1, [x29, #-0x8]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	sxtw	x0, w2
               	mov	x17, #0x0               // =0
               	orr	x21, x0, x17
               	sxtw	x20, w21
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
