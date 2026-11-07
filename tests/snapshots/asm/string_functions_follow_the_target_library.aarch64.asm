
string_functions_follow_the_target_library.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x24, x25, [sp, #0x30]
               	str	x26, [sp, #0x40]
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w16, [x1]
               	strh	w16, [x0]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w16, [x1]
               	strh	w16, [x0]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x70
               	bl	<addr>
               	mov	x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x3, lt
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	ldrb	w2, [x0, x1]
               	cbz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x40
               	mov	x4, #0x0                // =0
               	mov	x5, x3
               	mov	x6, x1
               	mov	x1, x20
               	mov	x3, x21
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x6f               // =111
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	mov	x1, #0x6f               // =111
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x22, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x23, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x24, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x6, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	mov	x5, x24
               	mov	x4, x23
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x7a               // =122
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x21, eq
               	sub	x0, x29, #0x40
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x40
               	add	x2, x0, #0xd
               	cmp	x1, x2
               	cset	x22, eq
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x40
               	cmp	x0, x1
               	cset	x3, eq
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x21
               	mov	x2, x22
               	bl	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x40
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x48               // =72
               	strb	w0, [x21]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x40
               	mov	x1, x21
               	mov	x3, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, x22
               	bl	<addr>
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldrh	w16, [x1, #0x8]
               	strh	w16, [x0, #0x8]
               	ldrb	w16, [x1, #0xa]
               	strb	w16, [x0, #0xa]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	cbz	x0, <addr>
               	mov	x1, x0
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x20, x29, #0x68
               	mov	x2, x20
               	bl	<addr>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	cbz	x0, <addr>
               	mov	x1, x0
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x21
               	mov	x2, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x5, x29, #0x58
               	ldurb	w1, [x29, #-0x56]
               	ldurb	w2, [x29, #-0x55]
               	ldurb	w3, [x29, #-0x54]
               	ldurb	w4, [x29, #-0x53]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x64               // =100
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x62               // =98
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	mov	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x1                // =1
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x61               // =97
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x0, #0x78               // =120
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x21, ne
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x22, ne
               	mov	x0, #0x21               // =33
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x23, ne
               	mov	x0, #0x71               // =113
               	bl	<addr>
               	mov	x24, x0
               	mov	x0, #0x51               // =81
               	bl	<addr>
               	mov	x25, x0
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x26, x0
               	mov	x0, #0xe9               // =233
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [sp]
               	mov	x0, x1
               	mov	x7, x26
               	mov	x6, x25
               	mov	x5, x24
               	mov	x4, x23
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x61               // =97
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x35               // =53
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	mov	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x26, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
