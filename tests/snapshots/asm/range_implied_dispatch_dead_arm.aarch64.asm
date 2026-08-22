
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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x3, x1
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x5, [x4]
               	add	x5, x5, x2
               	str	x5, [x4]
               	add	x3, x3, #0x1
               	cmp	w2, #0x1
               	b.lo	<addr>
               	mov	x0, #0x2                // =2
               	mov	x2, x1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, x1
               	b	<addr>
               	mov	w2, w0
               	mov	x17, #0x2               // =2
               	eor	x4, x2, x17
               	mov	w4, w4
               	cbnz	x4, <addr>
               	cmp	x3, #0x2
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
               	mov	w1, w1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	w1, #0x1
               	b.lo	<addr>
               	mov	x1, #0x14               // =20
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	str	w2, [x1]
               	ldr	w1, [x1]
               	mov	w1, w1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	w1, #0x1
               	b.lo	<addr>
               	mov	x1, #0x14               // =20
               	cmp	x1, #0xa
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
               	sxtw	x1, w1
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
               	mov	x2, x0
               	sxtw	x0, w2
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
