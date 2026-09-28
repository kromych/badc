
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
               	str	x20, [sp, #-0xd0]!
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
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
               	str	x0, [x2]
               	str	xzr, [x2, #0x8]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xa0
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	cbz	w20, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	mov	x0, #0x4                // =4
               	b	<addr>
