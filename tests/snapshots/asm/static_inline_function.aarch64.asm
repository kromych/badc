
static_inline_function.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x17, #0x1               // =1
               	and	x0, x2, x17
               	add	x1, x1, x0
               	lsr	x2, x2, #1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	bl	<addr>
               	cmp	x0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
