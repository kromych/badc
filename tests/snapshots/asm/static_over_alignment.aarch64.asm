
static_over_alignment.aarch64:	file format elf64-littleaarch64

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
               	mov	x17, #0x7f              // =127
               	and	x1, x0, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	ldr	x0, [x0]
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x17, #0x3f              // =63
               	and	x1, x0, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9                // =9
               	strb	w1, [x0]
               	mov	x17, #0xfff             // =4095
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
