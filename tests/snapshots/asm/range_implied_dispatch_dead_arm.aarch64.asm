
range_implied_dispatch_dead_arm.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, x0
               	eor	x1, x0, #0x2
               	cbz	w1, <addr>
               	ldr	x1, [x3]
               	add	x1, x1, x0
               	str	x1, [x3]
               	add	x2, x2, #0x1
               	cmp	w0, #0x1
               	b.lo	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	eor	x1, x0, #0x2
               	cbnz	w1, <addr>
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	ldr	w1, [x1]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.lo	<addr>
               	mov	x1, #0x14               // =20
               	cmp	w1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	str	w2, [x1]
               	ldr	w1, [x1]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.lo	<addr>
               	mov	x1, #0x14               // =20
               	cmp	w1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	ldr	x1, [x1]
               	mov	x2, #0x0                // =0
               	mov	x17, #0x1092            // =4242
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x1, x0
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x1092             // =4242
               	str	x3, [x1]
               	ldr	x1, [x1]
               	mov	x17, #0x1092            // =4242
               	cmp	x1, x17
               	b.ne	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, x2
               	ret
               	mov	x0, x2
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
