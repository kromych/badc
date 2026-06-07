
struct_field_displacement.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	ldrsw	x0, [x0, #0x4]
               	ret
               	ldr	x0, [x0, #0x8]
               	ret
               	ldrsh	x0, [x0, #0x10]
               	ret
               	ldrb	w0, [x0, #0x12]
               	ret
               	sxtw	x1, w1
               	str	w1, [x0, #0x4]
               	mov	x0, #0x0                // =0
               	ret
               	str	x1, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x16               // =22
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x1, #0x14d              // =333
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x1, #0x2c               // =44
               	strh	w1, [x0, #0x10]
               	sub	x0, x29, #0x18
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x12]
               	sub	x0, x29, #0x18
               	mov	x1, #0x63               // =99
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x309              // =777
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x309
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrsh	x0, [x0, #0x10]
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0, #0x12]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
