
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
               	sub	sp, sp, #0xc0
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x0, sp
               	and	x0, x0, #0x3f
               	add	x1, sp, #0x60
               	and	x1, x1, #0x1f
               	orr	x2, x0, x1
               	add	x1, sp, #0x40
               	and	x1, x1, #0x3f
               	orr	x2, x2, x1
               	add	x3, sp, #0x80
               	and	x3, x3, #0x1f
               	orr	x2, x2, x3
               	cbz	w2, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xb                // =11
               	strb	w2, [sp]
               	mov	x2, #0x16               // =22
               	str	w2, [sp, #0x6c]
               	mov	x2, #0x21               // =33
               	str	x2, [sp, #0x40]
               	mov	x2, #0x2c               // =44
               	str	w2, [sp, #0x80]
               	ldrb	w2, [sp]
               	mov	x17, #0xb               // =11
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	ldrsw	x2, [sp, #0x6c]
               	cmp	w2, #0x16
               	b.ne	<addr>
               	ldr	x2, [sp, #0x40]
               	cmp	x2, #0x21
               	b.ne	<addr>
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
