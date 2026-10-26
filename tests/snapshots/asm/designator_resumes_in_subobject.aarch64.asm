
designator_resumes_in_subobject.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x8]
               	eor	x1, x1, #0x78
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x14]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cbz	w0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x0                // =0
               	ret
