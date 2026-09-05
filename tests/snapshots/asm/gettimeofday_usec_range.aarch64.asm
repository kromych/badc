
gettimeofday_usec_range.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x22, #0x0               // =0
               	mov	x21, x22
               	b	<addr>
               	sub	x20, x29, #0x10
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldr	x0, [x20, #0x8]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldr	x0, [x20, #0x8]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	cset	x0, ge
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.le	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	cmp	w21, #0x64
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
