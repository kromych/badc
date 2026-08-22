
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x2                // =2
               	str	w0, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x7                // =7
               	str	w0, [x3]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	mov	x4, #0x0                // =0
               	mov	x0, #0x2                // =2
               	ldr	w6, [x1]
               	b	<addr>
               	ldrsw	x4, [x2]
               	add	x4, x4, #0x1
               	str	w4, [x2]
               	ldrsw	x4, [x3]
               	mov	w0, w0
               	cmp	x0, #0x2
               	b.lo	<addr>
               	ldr	w0, [x1]
               	mov	x17, #0x1               // =1
               	and	x5, x0, x17
               	mov	x0, #0x1                // =1
               	cbnz	x5, <addr>
               	ldr	w0, [x1]
               	mov	w5, w6
               	cmp	x0, x5
               	cset	x0, ne
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	mov	x5, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	b	<addr>
               	mov	w5, w0
               	cbnz	x5, <addr>
               	sxtw	x0, w4
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x0, [x2]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	str	w0, [x1]
               	mov	x0, #0x9                // =9
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	mov	x4, #0x0                // =0
               	mov	x0, #0x2                // =2
               	ldr	w6, [x1]
               	b	<addr>
               	ldrsw	x4, [x2]
               	add	x4, x4, #0x1
               	str	w4, [x2]
               	ldrsw	x4, [x3]
               	mov	w0, w0
               	cmp	x0, #0x2
               	b.lo	<addr>
               	ldr	w0, [x1]
               	mov	x17, #0x1               // =1
               	and	x5, x0, x17
               	mov	x0, #0x1                // =1
               	cbnz	x5, <addr>
               	ldr	w0, [x1]
               	mov	w5, w6
               	cmp	x0, x5
               	cset	x0, ne
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	mov	x5, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	b	<addr>
               	mov	w5, w0
               	cbnz	x5, <addr>
               	sxtw	x0, w4
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x2]
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
