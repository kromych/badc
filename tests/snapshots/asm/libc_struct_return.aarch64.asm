
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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x11               // =17
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x21, x29, #0x8
               	sub	x20, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	ldrsw	x0, [x20]
               	ldrsw	x1, [x20, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20]
               	ldrsw	x1, [x20, #0x4]
               	mul	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x64               // =100
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	ldrsw	x0, [x20]
               	ldrsw	x1, [x20, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
