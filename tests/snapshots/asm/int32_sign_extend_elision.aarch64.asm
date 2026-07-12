
int32_sign_extend_elision.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	sxtw	x0, w0
               	ret

<widen>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<sgn>:
               	mul	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, lt
               	ret

<pick>:
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, x1, lsl #2]
               	ret

<uwrap>:
               	mov	w0, w0
               	mov	w1, w1
               	add	x0, x0, x1
               	mov	w0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x8
               	sub	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
