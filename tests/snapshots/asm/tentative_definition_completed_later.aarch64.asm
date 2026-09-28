
tentative_definition_completed_later.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	cbnz	x0, <addr>
               	ldr	x0, [x1, #0x8]
               	cbnz	x0, <addr>
               	ldr	x0, [x1, #0x10]
               	cbnz	x0, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2, #0x10]
               	cbnz	x0, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x0, [x4]
               	cbnz	x0, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x0, [x3, #0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x1                // =1
               	str	x0, [x1]
               	mov	x5, #0x2                // =2
               	str	x5, [x1, #0x8]
               	mov	x6, #0x3                // =3
               	str	x6, [x1, #0x10]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x7]
               	ldr	x7, [x1, #0x8]
               	cmp	x7, #0x2
               	b.ne	<addr>
               	ldr	x7, [x1, #0x10]
               	cmp	x7, #0x3
               	b.ne	<addr>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x7, [x7]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x7, x17
               	b.eq	<addr>
               	mov	x0, x5
               	ret
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x7, [x7]
               	cmp	x7, x1
               	b.ne	<addr>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x7, [x7]
               	add	x1, x1, #0x10
               	cmp	x7, x1
               	b.eq	<addr>
               	mov	x0, x6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x6, #0x4                // =4
               	str	x6, [x1, #0x10]
               	mov	x7, #0x5                // =5
               	str	x7, [x2]
               	mov	x8, #0x6                // =6
               	str	x8, [x2, #0x10]
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	str	w0, [x9]
               	ldr	x1, [x1, #0x10]
               	cmp	x1, #0x4
               	b.ne	<addr>
               	ldr	x1, [x2]
               	cmp	x1, #0x5
               	b.ne	<addr>
               	ldr	x1, [x2, #0x10]
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x0, x6
               	ret
               	mov	x1, #0x7                // =7
               	strb	w1, [x4, #0x17]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w0, [x2]
               	ldrb	w2, [x4, #0x17]
               	eor	x2, x2, #0x7
               	cbnz	w2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x8                // =8
               	str	x4, [x2, #0x10]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	w0, [x6]
               	ldr	x2, [x2, #0x10]
               	cmp	x2, #0x8
               	b.eq	<addr>
               	mov	x0, x8
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x6, #0x9                // =9
               	str	x6, [x2, #0x10]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	str	w0, [x7]
               	ldr	x2, [x2, #0x10]
               	cmp	x2, #0x9
               	b.eq	<addr>
               	mov	x0, x1
               	ret
               	mov	x1, #0xa                // =10
               	str	x1, [x3, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, #0xb                // =11
               	strb	w1, [x7]
               	strb	w1, [x2]
               	and	x2, x3, #0x1f
               	cbnz	w2, <addr>
               	ldr	x2, [x3, #0x8]
               	cmp	x2, #0xa
               	b.eq	<addr>
               	mov	x0, x4
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x100000000        // =4294967296
               	str	x3, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	w0, [x3]
               	ldr	x3, [x2]
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, x6
               	ret
               	mov	x3, #-0x1               // =-1
               	str	x3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	strb	w5, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0xc                // =12
               	strb	w4, [x3]
               	ldrb	w2, [x2]
               	eor	x2, x2, #0x2
               	cbnz	w2, <addr>
               	ldrb	w2, [x3]
               	eor	x2, x2, #0xc
               	cbz	w2, <addr>
               	mov	x0, x1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0xd                // =13
               	str	x1, [x2, #0x10]
               	cmp	x1, #0xd
               	b.eq	<addr>
               	mov	x0, x4
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2, #0x8]
               	cmp	x3, #0x8
               	b.ne	<addr>
               	ldr	x2, [x2, #0x10]
               	cmp	x2, #0x9
               	b.eq	<addr>
               	mov	x0, x1
               	ret
               	ret
               	mov	x0, x7
               	ret
