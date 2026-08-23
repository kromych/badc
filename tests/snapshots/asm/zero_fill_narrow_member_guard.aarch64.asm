
zero_fill_narrow_member_guard.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x2]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x7                // =7
               	str	w0, [x5]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x3]
               	ldr	w7, [x2]
               	mov	x8, #0x1                // =1
               	mov	x6, x0
               	b	<addr>
               	ldrsw	x6, [x3]
               	add	x6, x6, #0x1
               	str	w6, [x3]
               	ldrsw	x6, [x5]
               	cmp	x4, #0x2
               	b.lo	<addr>
               	ldr	w1, [x2]
               	and	x4, x1, x8
               	mov	x1, #0x1                // =1
               	cbnz	x4, <addr>
               	ldr	w1, [x2]
               	mov	w4, w7
               	cmp	x1, x4
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x1, x0
               	mov	x4, x0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x4, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	mov	x4, x0
               	b	<addr>
               	mov	w4, w1
               	cbnz	x4, <addr>
               	sxtw	x0, w6
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x0, [x3]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	str	w0, [x2]
               	mov	x0, #0x9                // =9
               	str	w0, [x5]
               	mov	x0, #0x0                // =0
               	str	w0, [x3]
               	mov	x1, #0x2                // =2
               	ldr	w7, [x2]
               	mov	x8, #0x1                // =1
               	mov	x6, x0
               	b	<addr>
               	ldrsw	x6, [x3]
               	add	x6, x6, #0x1
               	str	w6, [x3]
               	ldrsw	x6, [x5]
               	cmp	x4, #0x2
               	b.lo	<addr>
               	ldr	w1, [x2]
               	and	x4, x1, x8
               	mov	x1, #0x1                // =1
               	cbnz	x4, <addr>
               	ldr	w1, [x2]
               	mov	w4, w7
               	cmp	x1, x4
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x1, x0
               	mov	x4, x0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x4, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	mov	x4, x0
               	b	<addr>
               	mov	w4, w1
               	cbnz	x4, <addr>
               	sxtw	x0, w6
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x3]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
