
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
               	sub	x0, x29, #0x8
               	mov	x20, #0x0               // =0
               	ldrb	w1, [x0]
               	add	x1, x1, #0x1
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x8]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0x1               // =1
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
