
tailcall_return_extension.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<load_le32>:
               	mov	x2, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x4
               	b.ge	<addr>
               	ldrb	w3, [x2, x1]
               	lsl	x4, x1, #3
               	sxtw	x4, w4
               	lsl	x3, x3, x4
               	add	x1, x1, #0x1
               	orr	x0, x0, x3
               	cmp	w1, #0x4
               	b.lt	<addr>
               	ret

<get_long>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x0                // =0
               	bl	<addr>
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
               	mov	x1, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1000             // =4096
               	movk	x0, #0xfebf, lsl #16
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xfebf, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #-0xf000           // =-61440
               	movk	x17, #0xfebf, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7f               // =127
               	sturb	w0, [x29, #-0x5]
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0x7fbf, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
