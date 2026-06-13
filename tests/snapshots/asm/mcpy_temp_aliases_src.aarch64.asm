
mcpy_temp_aliases_src.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	mov	x8, #0x9                // =9
               	mov	x9, #0xa                // =10
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	x0, x0, x2
               	sxtw	x0, w0
               	add	x0, x0, x3
               	sxtw	x0, w0
               	add	x0, x0, x4
               	sxtw	x0, w0
               	add	x0, x0, x5
               	sxtw	x0, w0
               	add	x0, x0, x6
               	sxtw	x0, w0
               	add	x0, x0, x7
               	sxtw	x0, w0
               	add	x0, x0, x8
               	sxtw	x0, w0
               	add	x0, x0, x9
               	sxtw	x0, w0
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x37
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x10]
               	mov	x17, #0x3333            // =13107
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x4444            // =17476
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
