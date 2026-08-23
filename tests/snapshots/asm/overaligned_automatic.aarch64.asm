
overaligned_automatic.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xa0
               	sub	sp, sp, #0xc0
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x2, sp
               	mov	x17, #0x3f              // =63
               	and	x4, x2, x17
               	add	x1, sp, #0x60
               	mov	x17, #0x1f              // =31
               	and	x0, x1, x17
               	orr	x0, x4, x0
               	add	x5, sp, #0x40
               	mov	x17, #0x3f              // =63
               	and	x6, x5, x17
               	orr	x0, x0, x6
               	add	x3, sp, #0x80
               	mov	x17, #0x1f              // =31
               	and	x7, x3, x17
               	orr	x0, x0, x7
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	strb	w0, [x2]
               	mov	x0, #0x16               // =22
               	str	w0, [x1, #0xc]
               	mov	x0, #0x21               // =33
               	add	x17, sp, #0x40
               	str	x0, [x17]
               	mov	x0, #0x2c               // =44
               	str	w0, [x3]
               	ldrb	w0, [x2]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	mov	w7, w0
               	mov	x0, #0x1                // =1
               	cbnz	x7, <addr>
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0x16
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x16, sp, #0x40
               	ldr	x0, [x16]
               	cmp	x0, #0x21
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x3]
               	cmp	w0, #0x2c
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x0, x4, x6
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
