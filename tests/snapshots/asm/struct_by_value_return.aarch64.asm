
struct_by_value_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	sub	x0, x29, #0x8
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<clobber>:
               	mov	x17, #0x1589            // =5513
               	movk	x17, #0x12, lsl #16
               	add	x0, x0, x17
               	sxtw	x0, w0
               	ret

<sum_pair_pair>:
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
               	ldrsw	x3, [x1]
               	sub	x2, x29, #0x10
               	ldrsw	x4, [x2]
               	add	x3, x3, x4
               	str	w3, [x0]
               	ldrsw	x1, [x1, #0x4]
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	str	w1, [x0, #0x4]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x16               // =22
               	bl	<addr>
               	sxtw	x20, w20
               	sxtw	x21, w0
               	mov	x22, #0x7               // =7
               	mov	x0, x22
               	bl	<addr>
               	mov	x17, #0x1589            // =5513
               	movk	x17, #0x12, lsl #16
               	add	x0, x0, x17
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x20, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x21, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w23
               	sxtw	x1, w1
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	sxtw	x20, w20
               	sxtw	x21, w0
               	mov	x0, #0x12c              // =300
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, #0x190              // =400
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w23
               	sxtw	x1, w1
               	cmp	x20, #0x64
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x21, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x1, #0x190
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	add	x1, x20, x22
               	add	x0, x21, x0
               	mov	w1, w1
               	mov	w0, w0
               	sxtw	x1, w1
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
