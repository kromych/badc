
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
               	sub	sp, sp, #0x80
               	sub	x1, x29, #0x80
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	ldrb	w1, [x0]
               	orr	x1, x1, #0x8
               	strb	w1, [x0]
               	ldrb	w1, [x0, #0x5]
               	orr	x1, x1, #0x1
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x0]
               	and	x1, x1, #0x8
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x5]
               	and	x1, x1, #0x1
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	and	x1, x1, #0x10
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	and	x2, x1, #0xfffffffffffffff7
               	strb	w2, [x0]
               	ldrb	w0, [x0]
               	and	x0, x0, #0x8
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
