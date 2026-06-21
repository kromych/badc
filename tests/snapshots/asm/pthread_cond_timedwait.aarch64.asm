
pthread_cond_timedwait.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x5d0              // =1488
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0xa0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0xb0
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x0, x29, #0xb0
               	str	x20, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0xb0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
