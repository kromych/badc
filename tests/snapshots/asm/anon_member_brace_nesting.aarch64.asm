
anon_member_brace_nesting.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x10]
               	ldrb	w3, [x0, #0x10]
               	cmp	w2, w3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w2, [x2, #0x10]
               	ldrb	w3, [x0, #0x10]
               	cmp	w2, w3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w2, [x2, #0x10]
               	ldrb	w0, [x0, #0x10]
               	cmp	w2, w0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldrb	w0, [x1, #0x10]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w1, [x0, #0x4]
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrb	w1, [x0, #0x8]
               	eor	x1, x1, #0x7
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x9]
               	eor	x0, x0, #0x8
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
