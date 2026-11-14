
locale_objects_and_the_l_functions.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	mov	x0, #0x1fbf             // =8127
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	cbnz	x21, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, x21
               	bl	<addr>
               	mov	x1, x0
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	str	x1, [sp, #0x18]
               	bl	<addr>
               	ldr	x1, [sp, #0x18]
               	cmp	x0, x21
               	b.ne	<addr>
               	mov	x0, x1
               	bl	<addr>
               	cmp	x0, x21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, #0x37               // =55
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x61               // =97
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	str	xzr, [x0, #0x30]
               	mov	x0, #0x46               // =70
               	stur	w0, [x29, #-0x24]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x2c]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x20               // =32
               	mov	x3, x20
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, #0x3                // =3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, x21
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	b	<addr>
               	sub	x0, x29, #0x78
               	mov	x1, #0x20               // =32
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x38
               	mov	x4, x20
               	bl	<addr>
               	cmp	x0, #0xa
               	b.ne	<addr>
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	sub	x0, x29, #0x78
               	mov	x1, #0x20               // =32
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0xa8]
               	mov	x2, x20
               	bl	<addr>
               	cmp	x0, #0x9
               	b.ne	<addr>
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x8                // =8
               	mov	x3, x20
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0xe                // =14
               	mov	x1, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	mov	x0, #0x1a               // =26
               	b	<addr>
               	mov	x0, #0x2                // =2
               	mov	x1, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x37               // =55
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x61               // =97
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x23               // =35
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x41               // =65
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x66               // =102
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	mov	x0, #0x37               // =55
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x61               // =97
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x41
               	b.ne	<addr>
               	mov	x0, #0x41               // =65
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	mov	x0, #0x37               // =55
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x61               // =97
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x37               // =55
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	mov	x0, #0x61               // =97
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x41               // =65
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x66               // =102
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	b	<addr>
               	mov	x0, #0x61               // =97
               	mov	x1, x20
               	bl	<addr>
               	mov	w0, w0
               	cmp	x0, #0x41
               	b.ne	<addr>
               	mov	x0, #0x41               // =65
               	mov	x1, x20
               	bl	<addr>
               	mov	w0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	str	x0, [sp, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	str	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	cbz	x16, <addr>
               	mov	x0, #0x61               // =97
               	mov	x2, x20
               	ldr	x1, [sp, #0x28]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x37               // =55
               	mov	x2, x20
               	ldr	x1, [sp, #0x28]
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x61               // =97
               	mov	x2, x20
               	ldr	x1, [sp, #0x20]
               	bl	<addr>
               	mov	w0, w0
               	cmp	x0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
