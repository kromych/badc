
overaligned_automatic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	sub	sp, sp, #0xc0
               	mov	x0, sp
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	add	x1, sp, #0x60
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	add	x1, sp, #0x40
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	add	x1, sp, #0x80
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	mov	x1, #0xb                // =11
               	strb	w1, [x0]
               	add	x0, sp, #0x60
               	mov	x1, #0x16               // =22
               	str	w1, [x0, #0xc]
               	mov	x0, #0x21               // =33
               	add	x17, sp, #0x40
               	str	x0, [x17]
               	add	x0, sp, #0x80
               	mov	x1, #0x2c               // =44
               	str	w1, [x0]
               	mov	x0, sp
               	ldrb	w0, [x0]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	add	x0, sp, #0x60
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x16
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	add	x16, sp, #0x40
               	ldr	x0, [x16]
               	cmp	x0, #0x21
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x80
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2c
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	add	x1, sp, #0x40
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	orr	x0, x0, x1
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
               	b	<addr>
