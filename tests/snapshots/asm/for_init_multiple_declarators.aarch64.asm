
for_init_multiple_declarators.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x70
               	mov	x2, #0x0                // =0
               	mov	x0, #0x3                // =3
               	mov	x1, x2
               	sxtw	x3, w2
               	cmp	x3, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	mov	x0, #0x4                // =4
               	mov	x1, #0x2                // =2
               	mov	x2, x3
               	sxtw	x4, w3
               	cmp	x4, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x3, w3
               	add	x3, x3, #0x1
               	b	<addr>
               	sxtw	x2, w2
               	add	x2, x2, x1
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x1, x2
               	cmp	x2, x0
               	b.gt	<addr>
               	b	<addr>
               	add	x2, x2, #0x1
               	b	<addr>
               	mul	x1, x1, x2
               	b	<addr>
               	cmp	x1, #0x78
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	mov	x2, #0x2                // =2
               	add	x0, x2, #0x3
               	sxtw	x0, w0
               	sxtw	x1, w2
               	cmp	x1, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	b	<addr>
               	sxtw	x1, w3
               	add	x3, x1, #0x1
               	b	<addr>
               	sxtw	x0, w3
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
