
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
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	cmp	w20, #0x2
               	b.ge	<addr>
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	mov	x17, #0x18              // =24
               	mul	x21, x20, x17
               	add	x22, x23, x21
               	ldr	x0, [x22]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0xb
               	b.ne	<addr>
               	ldr	x0, [x22, #0x8]
               	mov	x9, x0
               	blr	x9
               	cmp	w0, #0x16
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x21
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x2
               	b.lt	<addr>
               	bl	<addr>
               	cmp	w0, #0x16
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0xb
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0xb
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0xb
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	add	x0, x20, #0x14
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<check_const>:
               	mov	x0, #0x0                // =0
               	ret

<dispatch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, w0, sxtw #3]
               	br	x0
               	mov	x0, #0x64               // =100
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e7              // =999
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0xb
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0x16
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0x16
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0x16
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
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
               	mov	x0, #0x1f               // =31
               	b	<addr>
               	mov	x0, #0x1e               // =30
               	b	<addr>
