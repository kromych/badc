
parenthesized_address_constant.aarch64:	file format elf64-littleaarch64

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

<fn>:
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	ret

<check>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x0, x0, #0x4
               	cmp	x2, x0
               	b.ne	<addr>
               	ldr	x0, [x1]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x3, x1, #0x4
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x4, x2, #0x8
               	cmp	x3, x4
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	add	x1, x1, #0x14
               	cmp	x3, x1
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, #0x14
               	cmp	x1, x3
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.ne	<addr>
               	mov	x1, #0x2                // =2
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x66
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x8
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x1, x0, #0x4
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x0, x0, #0x4
               	cmp	x2, x0
               	b.ne	<addr>
               	ldr	x0, [x1]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x3, x1, #0x4
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x4, x2, #0x8
               	cmp	x3, x4
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	add	x1, x1, #0x14
               	cmp	x3, x1
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, #0x14
               	cmp	x1, x3
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x65
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x8
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x1, x0, #0x4
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x4d
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x58
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x63
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x6f
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
