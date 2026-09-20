
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x1, #0xfff
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x0, x2, #0xfff
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0xfff
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	cbnz	x3, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x4000             // =16384
               	ldrb	w3, [x2, x0]
               	cbnz	x3, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldr	x1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x18]
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x20]
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x28]
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x30]
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x38]
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	ldrsw	x3, [x1, #0x4]
               	add	x2, x2, x3
               	ldrsw	x3, [x1, #0x8]
               	add	x2, x2, x3
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x2, x1
               	cmp	w1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x9                // =9
               	str	x2, [x1]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0xff8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x17, #0x3fff            // =16383
               	add	x2, x2, x17
               	mov	x3, #0x7                // =7
               	strb	w3, [x2]
               	mov	x3, #0x5                // =5
               	str	x3, [x0, #0x38]
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0xff8]
               	add	x0, x0, x1
               	ldrb	w1, [x2]
               	add	x0, x0, x1
               	add	x0, x0, #0x5
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x4                // =4
               	ret
