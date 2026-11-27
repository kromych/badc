
math_errhandling_is_floating_exceptions.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	str	d8, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	fmov	d0, #-1.00000000
               	stur	d0, [x29, #-0x8]
               	bl	<addr>
               	str	wzr, [x0]
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x8]
               	fsqrt	d8, d0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d8, [sp], #0x30
               	ret
               	fcmp	d8, d8
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d8, [sp], #0x30
               	ret
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d8, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d8, [sp], #0x30
               	ret
