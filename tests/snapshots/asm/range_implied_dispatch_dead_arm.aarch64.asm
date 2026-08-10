
range_implied_dispatch_dead_arm.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	mov	w4, w0
               	add	x3, x3, x4
               	str	x3, [x2]
               	add	x1, x1, #0x1
               	mov	w0, w0
               	cmp	x0, #0x1
               	b.lo	<addr>
               	mov	x0, #0x2                // =2
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	w2, w0
               	mov	x17, #0x2               // =2
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x2
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	ldr	w0, [x0]
               	mov	w0, w0
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.lo	<addr>
               	mov	x0, #0x14               // =20
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	ldr	w0, [x0]
               	mov	w0, w0
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.lo	<addr>
               	mov	x0, #0x14               // =20
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x17, #0x1092            // =4242
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1092             // =4242
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x17, #0x1092            // =4242
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
