
pthread_cond_timedwait.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	sub	x2, x29, #0xb0
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xb0]
               	stur	xzr, [x29, #-0xa8]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xa0
               	bl	<addr>
               	str	x0, [sp, #0x8]
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x4                // =4
               	ldr	x16, [sp, #0x8]
               	cmp	w16, #0x0
               	csel	x0, x0, x1, ne
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
