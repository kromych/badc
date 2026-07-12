
callee_save_pair_large_frame.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
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

<bigframe>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x340
               	stp	x20, x21, [sp]
               	mov	x20, x0
               	mov	x21, x1
               	sub	x0, x29, #0x320
               	str	w20, [x0]
               	sub	x0, x29, #0x320
               	str	w21, [x0, #0x31c]
               	sub	x0, x29, #0x320
               	ldrsw	x0, [x0]
               	bl	<addr>
               	sub	x1, x29, #0x320
               	ldrsw	x1, [x1, #0x31c]
               	add	x0, x0, x1
               	add	x0, x0, x20
               	add	x0, x0, x21
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x340
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
