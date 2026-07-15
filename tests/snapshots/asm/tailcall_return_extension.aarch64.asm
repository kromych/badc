
tailcall_return_extension.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x1, w1
               	cmp	x1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x2, x0, x1
               	ldrb	w3, [x2]
               	lsl	x2, x1, #3
               	sxtw	x2, w2
               	lsl	x20, x3, x2
               	add	x1, x1, #0x1
               	bl	<addr>
               	orr	x0, x20, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<get_long>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	w0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<widen>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	w0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<load_alias>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x1, #0xfe               // =254
               	mov	x20, #0x7f              // =127
               	sub	x0, x29, #0x18
               	mov	x2, #0x0                // =0
               	strb	w2, [x0]
               	sub	x0, x29, #0x18
               	mov	x2, #0x10               // =16
               	strb	w2, [x0, #0x1]
               	sub	x0, x29, #0x18
               	mov	x2, #0xbf               // =191
               	strb	w2, [x0, #0x2]
               	sub	x0, x29, #0x18
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	w0, w0
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xfebf, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xfebf, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x0, x29, #0x18
               	strb	w20, [x0, #0x3]
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	w0, w0
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0x7fbf, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
