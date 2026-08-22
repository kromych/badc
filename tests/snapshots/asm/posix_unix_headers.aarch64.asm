
posix_unix_headers.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x210
               	sub	x3, x29, #0x208
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	add	x2, x3, x2
               	strb	w1, [x2]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x2, w0
               	cmp	x2, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x208
               	add	x1, x0, #0x0
               	ldrb	w2, [x1]
               	mov	x17, #0x8               // =8
               	orr	x2, x2, x17
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x5]
               	mov	x17, #0x1               // =1
               	orr	x2, x2, x17
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1]
               	mov	x17, #0x8               // =8
               	and	x3, x2, x17
               	cmp	x3, #0x0
               	cset	x2, eq
               	cbz	x3, <addr>
               	ldrb	w2, [x0, #0x5]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x1]
               	mov	x17, #0x10              // =16
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x1]
               	mov	x17, #0xfff7            // =65527
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x2, x17
               	strb	w3, [x1]
               	ldrb	w0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
