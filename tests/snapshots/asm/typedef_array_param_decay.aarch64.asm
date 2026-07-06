
typedef_array_param_decay.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, #0x0                // =0
               	sxtw	x2, w3
               	cmp	x2, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	b	<addr>
               	sxtw	x2, w3
               	lsl	x2, x2, #3
               	add	x4, x0, x2
               	add	x2, x1, x2
               	ldr	x2, [x2]
               	str	x2, [x4]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret

<sum>:
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	sxtw	x3, w1
               	cmp	x3, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	sxtw	x3, w1
               	ldr	x3, [x0, x3, lsl #3]
               	add	x2, x2, x3
               	b	<addr>
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x80
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	str	x3, [x0, x2, lsl #3]
               	b	<addr>
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x100
               	bl	<addr>
               	cmp	x0, #0x88
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	ldr	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	ldr	x0, [x0, #0x78]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
