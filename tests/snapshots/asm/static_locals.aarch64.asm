
static_locals.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0, #0x30]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	mov	x0, x1
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0xc]
               	add	x0, x0, #0x1
               	str	w0, [x1, #0xc]
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x34]
               	add	x0, x3, x0
               	str	w0, [x2, #0x34]
               	ldrsw	x3, [x1, #0xc]
               	add	x0, x3, x0
               	cmp	w0, #0xca
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x0, x3, #0x1
               	str	w0, [x1, #0xc]
               	ldrsw	x3, [x2, #0x34]
               	add	x0, x3, x0
               	str	w0, [x2, #0x34]
               	ldrsw	x3, [x1, #0xc]
               	add	x0, x3, x0
               	cmp	w0, #0x131
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x64               // =100
               	str	w0, [x1, #0xc]
               	mov	x0, #0x0                // =0
               	str	w0, [x2, #0x34]
               	ldrsw	x3, [x1, #0xc]
               	add	x3, x3, #0x1
               	str	w3, [x1, #0xc]
               	ldrsw	x4, [x2, #0x34]
               	add	x3, x4, x3
               	str	w3, [x2, #0x34]
               	ldrsw	x1, [x1, #0xc]
               	mov	x2, x3
               	add	x1, x1, x2
               	cmp	w1, #0xca
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x38]
               	add	x2, x2, #0x1
               	str	w2, [x1, #0x38]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	add	x2, x2, #0x1
               	str	w2, [x1, #0x38]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x10]
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x10]
               	cmp	w3, #0x3e9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x10]
               	mov	x2, x3
               	cmp	w2, #0x3ea
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	ldrsw	x2, [x1, #0x38]
               	add	x2, x2, #0x1
               	str	w2, [x1, #0x38]
               	mov	x1, x2
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	ret
