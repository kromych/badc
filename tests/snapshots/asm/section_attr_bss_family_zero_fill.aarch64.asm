
section_attr_bss_family_zero_fill.aarch64:	file format elf64-littleaarch64

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
               	mov	x17, #0xfff             // =4095
               	and	x0, x2, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xfff             // =4095
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xfff             // =4095
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x2, x1, lsl #3]
               	cbnz	x3, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x4000             // =16384
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	add	x5, x4, x1
               	ldrb	w5, [x5]
               	cbnz	x5, <addr>
               	add	x0, x1, #0x1
               	cmp	x0, x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x4, [x3, x1, lsl #3]
               	cbnz	x4, <addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x8
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x3, [x0, #0x4]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0x8]
               	add	x1, x1, x3
               	ldrsw	x0, [x0, #0xc]
               	add	x0, x1, x0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x9                // =9
               	str	x0, [x2]
               	mov	x0, #0x1                // =1
               	str	x0, [x2, #0xff8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3fff            // =16383
               	add	x1, x0, x17
               	mov	x0, #0x7                // =7
               	strb	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x3, #0x5                // =5
               	str	x3, [x0, #0x38]
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0xff8]
               	add	x2, x4, x2
               	ldrb	w1, [x1]
               	add	x1, x2, x1
               	add	x0, x1, x3
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x4                // =4
               	ret
