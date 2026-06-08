
struct_arg_in_registers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x10
               	ldrsh	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	ldrsh	x1, [x1, #0x6]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x1, [x16]
               	sxtw	x0, w0
               	sxtw	x2, w2
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x2, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x4]
               	lsl	x1, x1, #2
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	mov	x1, #0x64               // =100
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0xc8               // =200
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x8
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x151              // =337
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x539
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x28
               	mov	x1, #0x2                // =2
               	strh	w1, [x0, #0x4]
               	sub	x0, x29, #0x28
               	mov	x1, #0x3                // =3
               	strh	w1, [x0, #0x6]
               	sub	x0, x29, #0x28
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x28
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	sub	x0, x29, #0x38
               	mov	x1, #0xb                // =11
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x38
               	mov	x1, #0xd                // =13
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x1f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	sub	x1, x29, #0x8
               	mov	x2, #0x2                // =2
               	ldr	x1, [x1]
               	bl	<addr>
               	cmp	x0, #0x9eb
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x40
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x5
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
