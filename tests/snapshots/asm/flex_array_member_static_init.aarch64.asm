
flex_array_member_static_init.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x1]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x2, #0x0                // =0
               	add	x0, x1, #0x18
               	ldrb	w3, [x0]
               	cmp	w3, #0xff
               	b.eq	<addr>
               	add	x0, x2, #0xa
               	ret
               	mov	x4, #0x1                // =1
               	ldrb	w3, [x0, #0x1]
               	cmp	w3, #0xff
               	b.eq	<addr>
               	mov	x2, x4
               	b	<addr>
               	mov	x5, #0x2                // =2
               	ldrb	w3, [x0, #0x2]
               	cmp	w3, #0xfe
               	b.eq	<addr>
               	mov	x2, x5
               	b	<addr>
               	mov	x6, #0x3                // =3
               	ldrb	w3, [x0, #0x3]
               	cmp	w3, #0xfe
               	b.eq	<addr>
               	mov	x2, x6
               	b	<addr>
               	mov	x7, #0x4                // =4
               	ldrb	w3, [x0, #0x4]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x2, x7
               	b	<addr>
               	mov	x8, #0x5                // =5
               	ldrb	w3, [x0, #0x5]
               	cmp	w3, #0x6
               	b.eq	<addr>
               	mov	x2, x8
               	b	<addr>
               	mov	x3, #0x6                // =6
               	ldrb	w9, [x0, #0x6]
               	cmp	w9, #0x7
               	b.eq	<addr>
               	mov	x2, x3
               	b	<addr>
               	mov	x3, #0x7                // =7
               	ldrb	w0, [x0, #0x7]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x2, x3
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	add	x0, x1, #0x4
               	ldrb	w9, [x0]
               	cmp	w9, #0x68
               	b.eq	<addr>
               	add	x0, x2, #0x1e
               	ret
               	ldrb	w2, [x0, #0x1]
               	cmp	w2, #0x65
               	b.eq	<addr>
               	mov	x2, x4
               	b	<addr>
               	ldrb	w2, [x0, #0x2]
               	cmp	w2, #0x6c
               	b.eq	<addr>
               	mov	x2, x5
               	b	<addr>
               	ldrb	w2, [x0, #0x3]
               	cmp	w2, #0x6c
               	b.eq	<addr>
               	mov	x2, x6
               	b	<addr>
               	ldrb	w2, [x0, #0x4]
               	cmp	w2, #0x6f
               	b.eq	<addr>
               	mov	x2, x7
               	b	<addr>
               	ldrb	w0, [x0, #0x5]
               	cbz	x0, <addr>
               	mov	x2, x8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	ret
               	add	x1, x0, #0x18
               	ldr	x2, [x0, #0x20]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	ret
               	ldr	x1, [x0, #0x28]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x30]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x36               // =54
               	ret
               	ldr	x1, [x0, #0x38]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x38]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x37               // =55
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x40]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x40]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x48]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x38               // =56
               	ret
               	ldr	x1, [x0, #0x50]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x50]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x39               // =57
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x58]
               	cbz	x0, <addr>
               	mov	x0, #0x3a               // =58
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x3c               // =60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3d               // =61
               	ret
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x18]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3e               // =62
               	ret
               	ldr	x1, [x0, #0x20]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x3f               // =63
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x28]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x30]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x40               // =64
               	ret
               	ldr	x1, [x0, #0x38]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x38]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x41               // =65
               	ret
               	mov	x0, #0x0                // =0
               	ret
