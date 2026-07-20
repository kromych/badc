
inline_volatile_callee.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	w0, [x29, #0x10]
               	ldursw	x0, [x29, #0x10]
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<write_param>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	w0, [x29, #0x10]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #0x10]
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<local_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	add	x0, x20, x0
               	sub	x0, x0, #0x7
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
