
inline_struct_return_multi_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<reg_slot>:
               	mov	w2, w1
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x0, w0
               	ret
               	mov	w1, w1
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	ldrsw	x0, [x0, x1, lsl #2]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x14               // =20
               	mov	x0, #0x7865             // =30821
               	mov	x0, #0x28               // =40
               	mov	x0, #0xf1               // =241
               	movk	x0, #0x1, lsl #16
               	mov	x0, #0x14               // =20
               	mov	x0, #0xe5               // =229
               	mov	x0, #0x20               // =32
               	stur	w0, [x29, #-0xb0]
               	ldur	w0, [x29, #-0xb0]
               	mov	w0, w0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	w0, w0
               	mov	w0, w0
               	lsr	x0, x0, #5
               	mov	w3, w0
               	cmp	x3, #0x9
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x1                // =1
               	str	w4, [x3]
               	mov	w3, w0
               	cmp	x3, #0x4
               	b.lo	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x1                // =1
               	str	w4, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	w4, w0
               	mov	x17, #0x18              // =24
               	mul	x4, x4, x17
               	add	x3, x3, x4
               	ldr	w3, [x3]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x1                // =1
               	str	w4, [x3]
               	mov	w0, w0
               	mov	x17, #0x18              // =24
               	mul	x0, x0, x17
               	add	x0, x2, x0
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldrh	w4, [x0, #0x8]
               	ldrb	w5, [x0, #0xa]
               	ldrb	w6, [x0, #0xb]
               	ldr	x7, [x0, #0x10]
               	mov	w0, w2
               	mov	w2, w0
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x17, #0xf1              // =241
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	sxtw	x0, w0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w3
               	add	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	and	x1, x4, x17
               	add	x0, x0, x1
               	sxtb	x1, w5
               	add	x0, x0, x1
               	mov	x17, #0xff              // =255
               	and	x1, x6, x17
               	add	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	and	x1, x7, x17
               	add	x0, x0, x1
               	b	<addr>
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	ldrsw	x0, [x1, x0, lsl #2]
               	b	<addr>
