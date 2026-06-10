
struct_by_value_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sub	x2, x29, #0x8
               	str	w0, [x2]
               	sub	x0, x29, #0x8
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x0, w0
               	mov	x1, #0xdead             // =57005
               	mov	x2, #0xbeef             // =48879
               	mov	x3, #0xcafe             // =51966
               	mov	x4, #0xacef             // =44271
               	movk	x4, #0xf, lsl #16
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x1, x1, x3
               	sxtw	x1, w1
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x10
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	sub	x2, x29, #0x10
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x20, x29, #0x8
               	mov	x0, #0xb                // =11
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	sub	x16, x29, #0x90
               	str	x0, [x16]
               	sub	x0, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x0, #0x7                // =7
               	mov	x1, #0xdead             // =57005
               	mov	x2, #0xbeef             // =48879
               	mov	x3, #0xcafe             // =51966
               	mov	x4, #0xacef             // =44271
               	movk	x4, #0xf, lsl #16
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x1, x1, x3
               	sxtw	x1, w1
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x63               // =99
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x20
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sub	x16, x29, #0x98
               	str	x0, [x16]
               	sub	x0, x29, #0x98
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x30
               	mov	x0, #0x64               // =100
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	sub	x16, x29, #0xa0
               	str	x0, [x16]
               	sub	x0, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x20, x29, #0x38
               	mov	x0, #0x12c              // =300
               	mov	x1, #0x190              // =400
               	bl	<addr>
               	sub	x16, x29, #0xa8
               	str	x0, [x16]
               	sub	x0, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0]
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x190
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x50
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sub	x16, x29, #0xb0
               	str	x0, [x16]
               	sub	x21, x29, #0xb0
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sub	x16, x29, #0xb8
               	str	x0, [x16]
               	sub	x1, x29, #0xb8
               	mov	x0, x21
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0xc0
               	str	x0, [x16]
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
