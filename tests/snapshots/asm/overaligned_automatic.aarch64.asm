
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
               	mov	x0, sp
               	and	x2, x0, #0x3f
               	add	x1, sp, #0x60
               	and	x3, x1, #0x1f
               	orr	x4, x2, x3
               	add	x3, sp, #0x40
               	and	x3, x3, #0x3f
               	orr	x5, x4, x3
               	add	x4, sp, #0x80
               	and	x6, x4, #0x1f
               	orr	x5, x5, x6
               	cbz	w5, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0xb                // =11
               	strb	w5, [x0]
               	mov	x5, #0x16               // =22
               	str	w5, [x1, #0xc]
               	mov	x5, #0x21               // =33
               	str	x5, [sp, #0x40]
               	mov	x5, #0x2c               // =44
               	str	w5, [x4]
               	ldrb	w0, [x0]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x16
               	b.ne	<addr>
               	ldr	x0, [sp, #0x40]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	orr	x0, x2, x3
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
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
