
array_range_designator.aarch64:	file format elf64-littleaarch64

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

<op_read>:
               	mov	x0, #0xb                // =11
               	ret

<op_write>:
               	mov	x0, #0x16               // =22
               	ret

<check_struct>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x21, w20
               	mov	x17, #0x18              // =24
               	mul	x22, x21, x17
               	add	x0, x0, x22
               	ldr	x0, [x0]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0xb
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x22
               	ldr	x0, [x0, #0x8]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0x16
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x22
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0x16
               	mov	x20, #0x1               // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x38]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x48]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0xb
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x50]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0xb
               	cset	x20, ne
               	cbnz	x20, <addr>
               	mov	x20, #0x0               // =0
               	cbz	x20, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	add	x0, x20, #0x14
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<check_override>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0xb
               	mov	x21, #0x1               // =1
               	b.ne	<addr>
               	ldr	x0, [x20, #0x8]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0x16
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x18]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0x16
               	b.ne	<addr>
               	ldr	x0, [x20, #0x20]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0x16
               	cset	x21, ne
               	cbnz	x21, <addr>
               	mov	x21, #0x0               // =0
               	cbz	x21, <addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x21
               	b	<addr>

<dispatch>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	w0, [x29, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	mov	x0, #0x64               // =100
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x3e7              // =999
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
