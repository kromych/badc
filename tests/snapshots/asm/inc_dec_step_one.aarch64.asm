
inc_dec_step_one.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<minus_one>:
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<plus_one_l>:
               	add	x0, x0, #0x1
               	ret

<minus_neg_one>:
               	add	x0, x0, #0x1
               	ret

<count_up>:
               	mov	x3, x0
               	sxtw	x3, w3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<wrap>:
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
