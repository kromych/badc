
typedef_array_param_decay.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x3, #0x0                // =0
               	b	<addr>
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
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
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	mov	x1, #0x0                // =0
               	b	<addr>
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
               	mov	x1, #0x110              // =272
               	mov	x2, #0x2                // =2
               	sdiv	x1, x1, x2
               	cmp	x0, x1
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
               	add	x0, x0, #0x78
               	ldr	x0, [x0]
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
