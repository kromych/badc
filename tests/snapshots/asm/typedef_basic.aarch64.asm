
typedef_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	add	x15, x15, x14
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x19, [sp]
               	mov	x15, #0x64              // =100
               	mov	x14, #0x41              // =65
               	mov	x13, #0x2d2             // =722
               	movk	x13, #0x4996, lsl #16
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x12, x19
               	sub	x11, x29, #0x30
               	mov	x10, #0x7               // =7
               	str	w10, [x11]
               	sub	x9, x29, #0x30
               	add	x9, x9, #0x8
               	mov	x10, #0x0               // =0
               	str	x10, [x9]
               	sub	x11, x29, #0x38
               	mov	x10, #0xb               // =11
               	str	w10, [x11]
               	sub	x9, x29, #0x38
               	add	x9, x9, #0x4
               	mov	x10, #0x16              // =22
               	str	w10, [x9]
               	sub	x11, x29, #0x48
               	mov	x10, #0x1               // =1
               	str	w10, [x11]
               	sub	x9, x29, #0x48
               	add	x9, x9, #0x4
               	mov	x10, #0x2               // =2
               	str	w10, [x9]
               	sub	x11, x29, #0x48
               	add	x11, x11, #0x8
               	mov	x10, #0x3               // =3
               	str	w10, [x11]
               	add	x15, x15, x14
               	sxtw	x15, w15
               	cmp	x15, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w12, [x12]
               	mov	x17, #0x68              // =104
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x30
               	ldrsw	x12, [x12]
               	cmp	x12, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x38
               	ldrsw	x12, [x12]
               	sub	x0, x29, #0x38
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	add	x12, x12, x0
               	sxtw	x12, w12
               	cmp	x12, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x48
               	ldrsw	x12, [x12]
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	add	x12, x12, x0
               	sxtw	x12, w12
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	add	x12, x12, x0
               	sxtw	x12, w12
               	cmp	x12, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x2d2             // =722
               	movk	x17, #0x4996, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x14, #0x41
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
