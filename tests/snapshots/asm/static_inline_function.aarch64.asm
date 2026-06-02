
static_inline_function.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x14, w0
               	mov	x0, x14
               	ret
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #0x10]
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x8]
               	b	<addr>
               	ldur	x14, [x29, #0x10]
               	cbz	x14, <addr>
               	sub	x0, x29, #0x8
               	ldr	x14, [x0]
               	ldur	x13, [x29, #0x10]
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	add	x14, x14, x13
               	str	x14, [x0]
               	add	x13, x29, #0x10
               	ldr	x14, [x13]
               	lsr	x14, x14, #1
               	str	x14, [x13]
               	b	<addr>
               	ldur	x14, [x29, #-0x8]
               	mov	x0, x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x15, #0x2               // =2
               	mov	x17, #0x3               // =3
               	mul	x15, x15, x17
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x17, #0x3               // =3
               	mul	x15, x15, x17
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x18
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
