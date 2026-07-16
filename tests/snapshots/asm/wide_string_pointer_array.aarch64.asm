
wide_string_pointer_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	ldr	x2, [x0]
               	ldrsw	x2, [x2]
               	cmp	x2, #0x4c
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1, #0x1c]
               	cmp	x1, #0x42
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrsw	x1, [x1, #0x1c]
               	cmp	x1, #0x46
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldr	x1, [x0, #0x8]
               	ldrsw	x1, [x1, #0x20]
               	cmp	x1, #0x6c
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldr	x1, [x0, #0x8]
               	ldrsw	x1, [x1, #0x30]
               	cmp	x1, #0x79
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x2, [x0, #0x10]
               	mov	x1, #0x0                // =0
               	ldrsw	x2, [x2]
               	cmp	x2, #0x43
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x44
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cmp	x1, x2
               	cset	x1, eq
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0, #0x10]
               	cmp	x1, x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x1]
               	cmp	x1, #0x61
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x62
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x63
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x1]
               	cmp	x1, #0x78
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x79
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
