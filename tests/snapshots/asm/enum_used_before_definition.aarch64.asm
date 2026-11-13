
enum_used_before_definition.aarch64:	file format elf64-littleaarch64

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

<g>:
               	mov	x0, #0x80000000         // =2147483648
               	ret

<g_ref>:
               	mov	x0, #0x80000000         // =2147483648
               	ret

<take>:
               	mov	w0, w0
               	ret

<store>:
               	adrp	x1, <page>
               	mov	w0, w0
               	str	x0, [x1, #0x78]
               	ret

<id>:
               	ret

<make>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x80000000         // =2147483648
               	adrp	x1, <page>
               	ldr	w1, [x1, #0x30]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldr	w1, [x1]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0, #0x60]
               	bl	<addr>
               	mov	x1, #0x80000000         // =2147483648
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0, #0x68]
               	mov	x0, #0x80000000         // =2147483648
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x78]
               	mov	x2, #0x80000000         // =2147483648
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x1, #0x80000000         // =2147483648
               	str	x1, [x0, #0x78]
               	adrp	x0, <page>
               	ldr	x20, [x0, #0x10]
               	ldr	w0, [x20]
               	mov	x1, #0x80000000         // =2147483648
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	bl	<addr>
               	mov	x1, #0x80000000         // =2147483648
               	cmp	w0, w1
               	b.ne	<addr>
               	ldr	w0, [x20]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	adrp	x0, <page>
               	str	xzr, [x0, #0x78]
               	mov	x0, #0x80000000         // =2147483648
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x80000000         // =2147483648
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	adrp	x0, <page>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0, #0x70]
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x80000000         // =2147483648
               	blr	x1
               	mov	x1, #0x80000000         // =2147483648
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x80000000         // =2147483648
               	str	w1, [x0, #0x80]
               	ldr	w0, [x0, #0x80]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x17, #0x7fffffffffff    // =140737488355327
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
