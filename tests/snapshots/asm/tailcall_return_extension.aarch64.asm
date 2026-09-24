
tailcall_return_extension.aarch64:	file format elf64-littleaarch64

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

<load_le32>:
               	cmp	w1, #0x4
               	b.ge	<addr>
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldrb	w2, [x0, w1, sxtw]
               	lsl	x3, x1, #3
               	sxtw	x3, w3
               	lsl	x20, x2, x3
               	add	x1, x1, #0x1
               	bl	<addr>
               	orr	x0, x20, x0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0xfe               // =254
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	mov	x3, #0x10               // =16
               	strb	w3, [x0, #0x1]
               	mov	x3, #0xbf               // =191
               	strb	w3, [x0, #0x2]
               	strb	w2, [x0, #0x3]
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
               	sub	x0, x29, #0x8
               	mov	x1, #0x7f               // =127
               	strb	w1, [x0, #0x3]
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
