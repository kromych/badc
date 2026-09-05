
designator_positional_resume.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrsb	x4, [x4]
               	add	x5, x2, x1
               	ldrsb	x5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0xc
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	sub	x3, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x3, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x3, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x3, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x3, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrsb	x4, [x4]
               	add	x5, x2, x1
               	ldrsb	x5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0xc
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
