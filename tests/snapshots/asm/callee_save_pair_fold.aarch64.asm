
callee_save_pair_fold.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	add	x0, x0, x1
               	mov	x1, x2
               	cmp	x1, #0x0
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<quad>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x24, x4
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	sxtw	x20, w20
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x0, x20
               	add	x0, x0, x21
               	add	x0, x0, x22
               	add	x0, x0, x23
               	add	x0, x0, x24
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
