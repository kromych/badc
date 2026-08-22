
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
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0xff               // =255
               	sturb	w2, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	ldrb	w3, [x2]
               	add	x3, x3, #0x1
               	strb	w3, [x2]
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	mov	x2, x0
               	sxtw	x2, w2
               	cmp	x2, #0x1
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldurb	w2, [x29, #-0x8]
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	sxtw	x0, w1
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
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
