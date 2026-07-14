
packed_anon_union_layout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1b0
               	str	x19, [sp]
               	sub	x0, x29, #0x100
               	add	x0, x0, #0x80
               	sub	x1, x29, #0x100
               	sub	x0, x0, x1
               	cmp	x0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x180
               	mov	x1, #0x0                // =0
               	mov	x2, #0x80               // =128
               	bl	<addr>
               	sub	x0, x29, #0x180
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	sub	x0, x29, #0x180
               	mov	x1, #0x8                // =8
               	str	w1, [x0, #0x3c]
               	sub	x0, x29, #0x180
               	mov	x1, #0x14               // =20
               	str	w1, [x0, #0x44]
               	sub	x0, x29, #0x180
               	ldrb	w1, [x0]
               	mov	x17, #0x3               // =3
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x3c]
               	mov	x17, #0x8               // =8
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0, #0x44]
               	mov	x17, #0x14              // =20
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
