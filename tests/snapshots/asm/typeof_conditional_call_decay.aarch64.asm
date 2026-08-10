
typeof_conditional_call_decay.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3                // =3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x0, #0x1
               	add	x2, x1, x0
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	cmp	x0, #0x3
               	b.hs	<addr>
               	cmp	x3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	strh	w0, [x1, #0x8]
               	sub	x1, x29, #0x28
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	w0, [x1, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x0
               	b	<addr>
