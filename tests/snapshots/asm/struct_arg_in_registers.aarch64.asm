
struct_arg_in_registers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sum_wide>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sum_mixed>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x10
               	ldrsh	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sub	x1, x29, #0x10
               	ldrsh	x1, [x1, #0x6]
               	add	x0, x0, x1
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sum_nested>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<around>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x1, [x16]
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret

<two>:
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
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	lsl	x0, x0, #1
               	add	x0, x1, x0
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x4]
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<mutate>:
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
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
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
               	ldrsw	x1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
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
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
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
               	ldrsw	x1, [x0]
               	ldrsh	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsh	x2, [x0, #0x6]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
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
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x1f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x1, x1, #0x9
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	add	x0, x0, #0x7d0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x9eb
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x40
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	sub	x1, x29, #0x40
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x40
               	ldrsw	x2, [x0]
               	ldrsw	x0, [x0, #0x4]
               	lsl	x0, x0, #1
               	add	x0, x2, x0
               	ldrsw	x2, [x1]
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldrsw	x1, [x1, #0x4]
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
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
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
