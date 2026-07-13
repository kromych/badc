
array_range_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x390              // =912
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0xb                // =11
               	ret

<op_write>:
               	mov	x0, #0x16               // =22
               	ret

<check_struct>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	mov	x17, #0x18              // =24
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x0, [x0]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0xb
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	mov	x17, #0x18              // =24
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x0, [x0, #0x8]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x16
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	mov	x17, #0x18              // =24
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x16
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x38]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0xb
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x40]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x48]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0xb
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x50]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0xb
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x58]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x20, #0x14
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	b	<addr>

<check_override>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0xb
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldr	x0, [x20, #0x8]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x16
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0x10]
               	cmp	x0, #0x64
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x18]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x16
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldr	x0, [x20, #0x20]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x16
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0x28]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_const>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cmp	x1, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x24]
               	cmp	x1, #0x7
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x1, [x0, #0xc]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x28]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x1, [x0, #0x30]
               	cmp	x1, #0x9
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x3c]
               	cmp	x0, #0x9
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<dispatch>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x1, [x0, #0x40]
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x8]
               	b	<addr>
               	adr	x1, <addr>
               	str	x1, [x0]
               	adr	x1, <addr>
               	str	x1, [x0, #0x8]
               	adr	x1, <addr>
               	str	x1, [x0, #0x10]
               	adr	x1, <addr>
               	str	x1, [x0, #0x18]
               	adr	x1, <addr>
               	str	x1, [x0, #0x20]
               	adr	x1, <addr>
               	str	x1, [x0, #0x28]
               	adr	x1, <addr>
               	str	x1, [x0, #0x30]
               	adr	x1, <addr>
               	str	x1, [x0, #0x38]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x40]
               	stur	x1, [x29, #-0x8]
               	ldursw	x1, [x29, #0x10]
               	ldr	x0, [x0, x1, lsl #3]
               	br	x0
               	mov	x0, #0x64               // =100
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x3e7              // =999
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
