
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
               	adrp	x2, <page>
               	mov	x1, x0
               	ldr	x3, [x2, #0x20]
               	add	x3, x3, x0
               	str	x3, [x2, #0x20]
               	add	x1, x1, #0x1
               	mov	x3, #0x1                // =1
               	mov	x4, #0x2                // =2
               	cmp	w0, #0x1
               	csel	x0, x3, x4, lo
               	cmp	w0, #0x2
               	b.ne	<addr>
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x28]
               	ldr	w2, [x0, #0x28]
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.lo	<addr>
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x28]
               	ldr	w0, [x0, #0x28]
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.lo	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	str	x1, [x0, #0x30]
               	ldr	x0, [x0, #0x30]
               	mov	x17, #0x1092            // =4242
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x1092             // =4242
               	str	x1, [x0, #0x30]
               	ldr	x0, [x0, #0x30]
               	mov	x17, #0x1092            // =4242
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x3                // =3
               	ret
