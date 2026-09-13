
libc_struct_return.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x11               // =17
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldr	w0, [x1]
               	ldr	w1, [x1, #0x4]
               	add	x2, x0, x1
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mul	x0, x0, x1
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x64               // =100
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	add	x0, x1, x0
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
