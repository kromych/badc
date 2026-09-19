
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
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1]
               	add	x2, x2, #0x1
               	strb	w2, [x1]
               	ldrb	w1, [x1]
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x8]
               	cbnz	x1, <addr>
               	mov	x17, #0x0               // =0
               	orr	x20, x0, x17
               	sxtw	x1, w20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
