
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
               	mov	x1, sp
               	and	x2, x1, #0x3f
               	add	x0, sp, #0x60
               	and	x3, x0, #0x1f
               	orr	x5, x2, x3
               	add	x3, sp, #0x40
               	and	x4, x3, #0x3f
               	orr	x6, x5, x4
               	add	x5, sp, #0x80
               	and	x7, x5, #0x1f
               	orr	x6, x6, x7
               	cbz	x6, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0xb                // =11
               	strb	w6, [x1]
               	mov	x6, #0x16               // =22
               	str	w6, [x0, #0xc]
               	mov	x6, #0x21               // =33
               	str	x6, [sp, #0x40]
               	mov	x6, #0x2c               // =44
               	str	w6, [x5]
               	ldrb	w5, [x1]
               	mov	x17, #0xb               // =11
               	eor	x5, x5, x17
               	cmp	w5, #0x0
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x16
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	x0, [sp, #0x40]
               	cmp	x0, #0x21
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	orr	x1, x2, x4
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
