
struct_field_displacement.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
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
               	sxtw	x1, w1
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	str	w1, [x0, #0x4]
               	mov	x0, #0x0                // =0
               	ret
               	ldr	x2, [x0, #0x8]
               	add	x1, x2, x1
               	str	x1, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ret
               	ldrb	w1, [x0, #0x12]
               	add	x1, x1, #0x1
               	strb	w1, [x0, #0x12]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	sub	x0, x29, #0x18
               	mov	x20, #0x1               // =1
               	str	w20, [x0]
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
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x313
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrsh	x0, [x0, #0x10]
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0, #0x12]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
