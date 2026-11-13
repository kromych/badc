
c4.aarch64:	file format elf64-littleaarch64

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

<next>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x78]
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x78]
               	adrp	x0, <page>
               	adrp	x20, <page>
               	ldr	x1, [x20, #0x20]
               	ldrb	w1, [x1]
               	str	x1, [x0, #0x58]
               	cbz	x1, <addr>
               	ldr	x1, [x20, #0x20]
               	add	x2, x1, #0x1
               	str	x2, [x20, #0x20]
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x21, <page>
               	ldr	x3, [x21, #0x28]
               	sub	x2, x2, x3
               	bl	<addr>
               	ldr	x0, [x20, #0x20]
               	str	x0, [x21, #0x28]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x1, #0x8
               	str	x1, [x20, #0x40]
               	ldr	x1, [x1]
               	add	x1, x1, x1, lsl #2
               	add	x1, x2, x1
               	bl	<addr>
               	ldr	x1, [x20, #0x40]
               	ldr	x0, [x1]
               	cmp	x0, #0x7
               	b.gt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x1, #0x8
               	str	x1, [x20, #0x40]
               	ldr	x1, [x1]
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x1, [x20, #0x40]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x1, x0
               	b.lo	<addr>
               	b	<addr>
               	cmp	x1, #0x23
               	b.ne	<addr>
               	ldr	x0, [x20, #0x20]
               	ldrb	w1, [x0]
               	cbz	w1, <addr>
               	ldrb	w0, [x0]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	ldr	x0, [x20, #0x20]
               	add	x0, x0, #0x1
               	str	x0, [x20, #0x20]
               	ldr	x0, [x20, #0x20]
               	ldrb	w1, [x0]
               	cbnz	w1, <addr>
               	b	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x61
               	b.lt	<addr>
               	cmp	x1, #0x7a
               	b.le	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x41
               	b.lt	<addr>
               	cmp	x1, #0x5a
               	b.le	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x5f
               	b.eq	<addr>
               	cmp	x1, #0x30
               	b.lt	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x39
               	b.le	<addr>
               	ldr	x0, [x0, #0x58]
               	cmp	x0, #0x2f
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x2f
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cbz	w2, <addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0xa
               	b.eq	<addr>
               	ldr	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cbnz	w2, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x27
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x22
               	b.eq	<addr>
               	cmp	x1, #0x3d
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x2b
               	b.eq	<addr>
               	cmp	x1, #0x2d
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x21
               	b.eq	<addr>
               	cmp	x1, #0x3c
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x3e
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x7c
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x26
               	b.eq	<addr>
               	cmp	x1, #0x5e
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x25
               	b.eq	<addr>
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	cmp	x1, #0x5b
               	b.eq	<addr>
               	cmp	x1, #0x3f
               	b.eq	<addr>
               	ldr	x0, [x0, #0x58]
               	cmp	x0, #0x7e
               	b.eq	<addr>
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	cmp	x0, #0x28
               	b.eq	<addr>
               	cmp	x0, #0x29
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x5d
               	b.eq	<addr>
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	cmp	x0, #0x3a
               	b.ne	<addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x8f               // =143
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0xa4               // =164
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x9f               // =159
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0xa1               // =161
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x93               // =147
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x26
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x91               // =145
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x94               // =148
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x7c
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x90               // =144
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x92               // =146
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x20]
               	ldrb	w2, [x0]
               	cmp	w2, #0x3d
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	str	x0, [x1, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x9a               // =154
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrb	w2, [x0]
               	cmp	w2, #0x3e
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	str	x0, [x1, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x9c               // =156
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x98               // =152
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x20]
               	ldrb	w2, [x0]
               	cmp	w2, #0x3d
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	str	x0, [x1, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x99               // =153
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrb	w2, [x0]
               	cmp	w2, #0x3c
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	str	x0, [x1, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x9b               // =155
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x97               // =151
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x3d
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x96               // =150
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x2d
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0xa3               // =163
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x9e               // =158
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x2b
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0xa2               // =162
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x9d               // =157
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x3d
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	mov	x1, #0x95               // =149
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x8e               // =142
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x2, <page>
               	ldr	x6, [x2, #0x30]
               	adrp	x0, <page>
               	adrp	x3, <page>
               	adrp	x1, <page>
               	ldr	x4, [x0, #0x20]
               	ldrb	w4, [x4]
               	cbz	w4, <addr>
               	ldr	x4, [x0, #0x20]
               	ldrb	w4, [x4]
               	ldr	x5, [x3, #0x58]
               	cmp	x4, x5
               	b.eq	<addr>
               	ldr	x4, [x0, #0x20]
               	add	x4, x4, #0x1
               	str	x4, [x0, #0x20]
               	ldurb	w4, [x4, #-0x1]
               	str	x4, [x1, #0x60]
               	cmp	w4, #0x5c
               	b.ne	<addr>
               	ldr	x4, [x0, #0x20]
               	add	x4, x4, #0x1
               	str	x4, [x0, #0x20]
               	ldurb	w4, [x4, #-0x1]
               	str	x4, [x1, #0x60]
               	cmp	w4, #0x6e
               	b.ne	<addr>
               	mov	x4, #0xa                // =10
               	str	x4, [x1, #0x60]
               	ldr	x4, [x3, #0x58]
               	cmp	x4, #0x22
               	b.ne	<addr>
               	ldr	x4, [x2, #0x30]
               	add	x4, x4, #0x1
               	str	x4, [x2, #0x30]
               	ldr	x5, [x1, #0x60]
               	sturb	w5, [x4, #-0x1]
               	ldr	x4, [x0, #0x20]
               	ldrb	w4, [x4]
               	cbnz	w4, <addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x22
               	b.ne	<addr>
               	adrp	x0, <page>
               	str	x6, [x0, #0x60]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x80               // =128
               	str	x1, [x0, #0x58]
               	b	<addr>
               	adrp	x0, <page>
               	mov	x1, #0xa0               // =160
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x58]
               	mov	x3, #0xa                // =10
               	subs	x1, x1, #0x30
               	str	x1, [x0, #0x60]
               	b.eq	<addr>
               	ldr	x1, [x20, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x30
               	b.lt	<addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0x39
               	b.gt	<addr>
               	ldr	x1, [x0, #0x60]
               	mul	x2, x1, x3
               	ldr	x1, [x20, #0x20]
               	add	x1, x1, #0x1
               	str	x1, [x20, #0x20]
               	ldurb	w1, [x1, #-0x1]
               	add	x1, x2, x1
               	sub	x1, x1, #0x30
               	str	x1, [x0, #0x60]
               	ldr	x1, [x20, #0x20]
               	ldrb	w2, [x1]
               	cmp	w2, #0x30
               	b.ge	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x80               // =128
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x20]
               	ldrb	w3, [x3]
               	cmp	w3, #0x78
               	b.eq	<addr>
               	ldr	x3, [x1, #0x20]
               	ldrb	w3, [x3]
               	cmp	w3, #0x58
               	b.ne	<addr>
               	b	<addr>
               	cmp	x3, #0x30
               	b.lt	<addr>
               	cmp	x3, #0x39
               	b.le	<addr>
               	ldr	x3, [x2, #0x58]
               	cmp	x3, #0x61
               	b.lt	<addr>
               	cmp	x3, #0x66
               	b.le	<addr>
               	ldr	x3, [x2, #0x58]
               	cmp	x3, #0x41
               	b.lt	<addr>
               	cmp	x3, #0x46
               	b.gt	<addr>
               	ldr	x4, [x0, #0x60]
               	ldr	x3, [x2, #0x58]
               	and	x5, x3, #0xf
               	add	x4, x5, x4, lsl #4
               	mov	x5, #0x9                // =9
               	mov	x6, #0x0                // =0
               	cmp	x3, #0x41
               	csel	x3, x5, x6, ge
               	add	x3, x4, x3
               	str	x3, [x0, #0x60]
               	ldr	x3, [x1, #0x20]
               	add	x3, x3, #0x1
               	str	x3, [x1, #0x20]
               	ldrb	w3, [x3]
               	str	x3, [x2, #0x58]
               	cbnz	x3, <addr>
               	b	<addr>
               	ldrb	w2, [x2]
               	cmp	w2, #0x37
               	b.gt	<addr>
               	ldr	x3, [x0, #0x60]
               	ldr	x2, [x1, #0x20]
               	add	x2, x2, #0x1
               	str	x2, [x1, #0x20]
               	ldurb	w2, [x2, #-0x1]
               	add	x2, x2, x3, lsl #3
               	sub	x2, x2, #0x30
               	str	x2, [x0, #0x60]
               	ldr	x2, [x1, #0x20]
               	ldrb	w3, [x2]
               	cmp	w3, #0x30
               	b.ge	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	sub	x20, x1, #0x1
               	mov	x3, #0x93               // =147
               	adrp	x1, <page>
               	ldr	x2, [x0, #0x20]
               	ldrb	w2, [x2]
               	cmp	w2, #0x61
               	b.lt	<addr>
               	ldr	x2, [x0, #0x20]
               	ldrb	w2, [x2]
               	cmp	w2, #0x7a
               	b.le	<addr>
               	ldr	x2, [x0, #0x20]
               	ldrb	w4, [x2]
               	cmp	w4, #0x41
               	b.lt	<addr>
               	ldrb	w2, [x2]
               	cmp	w2, #0x5a
               	b.le	<addr>
               	ldr	x2, [x0, #0x20]
               	ldrb	w4, [x2]
               	cmp	w4, #0x30
               	b.lt	<addr>
               	ldrb	w2, [x2]
               	cmp	w2, #0x39
               	b.le	<addr>
               	ldr	x2, [x0, #0x20]
               	ldrb	w2, [x2]
               	cmp	w2, #0x5f
               	b.ne	<addr>
               	ldr	x2, [x1, #0x58]
               	mul	x4, x2, x3
               	ldr	x2, [x0, #0x20]
               	add	x2, x2, #0x1
               	str	x2, [x0, #0x20]
               	ldurb	w2, [x2, #-0x1]
               	add	x2, x4, x2
               	str	x2, [x1, #0x58]
               	b	<addr>
               	adrp	x21, <page>
               	ldr	x0, [x21, #0x58]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	sub	x1, x1, x20
               	add	x0, x1, x0, lsl #6
               	str	x0, [x21, #0x58]
               	adrp	x22, <page>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	str	x0, [x22, #0x48]
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	add	x1, x1, #0x48
               	str	x1, [x0, #0x48]
               	ldr	x0, [x22, #0x48]
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	ldr	x1, [x21, #0x58]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0, #0x10]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	sub	x2, x1, x20
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldr	x1, [x1]
               	str	x1, [x0, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	str	x20, [x1, #0x10]
               	ldr	x2, [x0, #0x48]
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x58]
               	str	x3, [x2, #0x8]
               	ldr	x2, [x0, #0x48]
               	mov	x0, #0x85               // =133
               	str	x0, [x2]
               	str	x0, [x1, #0x58]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<expr>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x23, x0
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x58]
               	cbz	x0, <addr>
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	str	x0, [x1]
               	bl	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	adrp	x22, <page>
               	ldr	x20, [x22, #0x68]
               	cmp	x1, #0x8e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x21, <page>
               	ldr	x1, [x21, #0x38]
               	ldr	x0, [x1]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	ldr	x0, [x1]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	ldr	x0, [x21, #0x38]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x21, #0x38]
               	adrp	x0, <page>
               	str	x20, [x0, #0x68]
               	mov	x0, #0xc                // =12
               	mov	x2, #0xb                // =11
               	cmp	x20, #0x0
               	csel	x0, x2, x0, ne
               	str	x0, [x1]
               	b	<addr>
               	cmp	x1, #0x8f
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x4                // =4
               	str	x0, [x1]
               	ldr	x0, [x20, #0x38]
               	add	x22, x0, #0x8
               	str	x22, [x20, #0x38]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x3a
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x0, x0, #0x18
               	str	x0, [x22]
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x2                // =2
               	str	x0, [x1]
               	ldr	x0, [x20, #0x38]
               	add	x21, x0, #0x8
               	str	x21, [x20, #0x38]
               	mov	x0, #0x8f               // =143
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x90
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x5                // =5
               	str	x0, [x1]
               	ldr	x0, [x20, #0x38]
               	add	x21, x0, #0x8
               	str	x21, [x20, #0x38]
               	mov	x0, #0x91               // =145
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x0, #0x1                // =1
               	str	x0, [x22, #0x68]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x91
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x4                // =4
               	str	x0, [x1]
               	ldr	x0, [x20, #0x38]
               	add	x21, x0, #0x8
               	str	x21, [x20, #0x38]
               	mov	x0, #0x92               // =146
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x0, #0x1                // =1
               	str	x0, [x22, #0x68]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x92
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x93               // =147
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xe                // =14
               	str	x0, [x1]
               	mov	x0, #0x1                // =1
               	str	x0, [x22, #0x68]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x93
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x94               // =148
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xf                // =15
               	str	x0, [x1]
               	mov	x0, #0x1                // =1
               	str	x0, [x22, #0x68]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x95               // =149
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x10               // =16
               	str	x0, [x1]
               	mov	x0, #0x1                // =1
               	str	x0, [x22, #0x68]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x95
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x11               // =17
               	str	x0, [x1]
               	mov	x0, #0x1                // =1
               	str	x0, [x22, #0x68]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x96
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x12               // =18
               	str	x0, [x1]
               	mov	x0, #0x1                // =1
               	str	x0, [x22, #0x68]
               	b	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x97
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x13               // =19
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	adrp	x2, <page>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0x98
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x14               // =20
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0x99
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x15               // =21
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0x9a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x16               // =22
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0x9b
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x17               // =23
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0x9c
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x18               // =24
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x1, [x2, #0x58]
               	cmp	x1, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x21, #0xd               // =13
               	str	x21, [x2]
               	mov	x0, #0x9f               // =159
               	str	x1, [sp, #0x30]
               	bl	<addr>
               	ldr	x1, [sp, #0x30]
               	adrp	x0, <page>
               	str	x20, [x0, #0x68]
               	cmp	x20, #0x2
               	b.le	<addr>
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	str	x21, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x1                // =1
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x8                // =8
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x1b               // =27
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x19               // =25
               	str	x0, [x2]
               	b	<addr>
               	cmp	x1, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x21, #0xd               // =13
               	str	x21, [x2]
               	mov	x0, #0x9f               // =159
               	str	x1, [sp, #0x28]
               	bl	<addr>
               	ldr	x1, [sp, #0x28]
               	cmp	x20, #0x2
               	b.le	<addr>
               	adrp	x2, <page>
               	ldr	x0, [x2, #0x68]
               	cmp	x20, x0
               	b.ne	<addr>
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	mov	x0, #0x1a               // =26
               	str	x0, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	str	x21, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	mov	x4, #0x1                // =1
               	str	x4, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	mov	x0, #0x8                // =8
               	str	x0, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	mov	x0, #0x1c               // =28
               	str	x0, [x3]
               	str	x4, [x2, #0x68]
               	b	<addr>
               	adrp	x0, <page>
               	str	x20, [x0, #0x68]
               	cmp	x20, #0x2
               	b.le	<addr>
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x1                // =1
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x8                // =8
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x1b               // =27
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x1a               // =26
               	str	x0, [x2]
               	b	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x1a               // =26
               	str	x0, [x2]
               	b	<addr>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0xa0
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x1c               // =28
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0xa1
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x20, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x20, #0x38]
               	mov	x0, #0x1d               // =29
               	str	x0, [x1]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x1, [x2, #0x58]
               	cmp	x1, #0xa2
               	b.eq	<addr>
               	cmp	x1, #0xa3
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x38]
               	ldr	x0, [x3]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	str	x0, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	mov	x0, #0xa                // =10
               	str	x0, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	mov	x5, #0xd                // =13
               	str	x5, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x4, x0, #0x8
               	str	x4, [x1, #0x38]
               	mov	x3, #0x1                // =1
               	str	x3, [x4]
               	ldr	x0, [x1, #0x38]
               	add	x6, x0, #0x8
               	str	x6, [x1, #0x38]
               	adrp	x4, <page>
               	mov	x0, #0x8                // =8
               	ldr	x7, [x4, #0x68]
               	cmp	x7, #0x2
               	csel	x0, x0, x3, gt
               	str	x0, [x6]
               	ldr	x0, [x1, #0x38]
               	add	x6, x0, #0x8
               	str	x6, [x1, #0x38]
               	mov	x0, #0x19               // =25
               	mov	x7, #0x1a               // =26
               	ldr	x2, [x2, #0x58]
               	cmp	x2, #0xa2
               	csel	x0, x0, x7, eq
               	str	x0, [x6]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0xc                // =12
               	mov	x6, #0xb                // =11
               	ldr	x7, [x4, #0x68]
               	cmp	x7, #0x0
               	csel	x0, x6, x0, ne
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	str	x5, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	str	x3, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x8                // =8
               	ldr	x4, [x4, #0x68]
               	cmp	x4, #0x2
               	csel	x0, x0, x3, gt
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	adrp	x0, <page>
               	mov	x1, #0x1a               // =26
               	mov	x3, #0x19               // =25
               	ldr	x0, [x0, #0x58]
               	cmp	x0, #0xa2
               	csel	x0, x1, x3, eq
               	str	x0, [x2]
               	bl	<addr>
               	b	<addr>
               	ldr	x3, [x1, #0x38]
               	ldr	x0, [x3]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	str	x0, [x3]
               	ldr	x0, [x1, #0x38]
               	add	x3, x0, #0x8
               	str	x3, [x1, #0x38]
               	mov	x0, #0x9                // =9
               	str	x0, [x3]
               	b	<addr>
               	cmp	x1, #0xa4
               	b.ne	<addr>
               	str	x2, [sp, #0x38]
               	bl	<addr>
               	ldr	x2, [sp, #0x38]
               	adrp	x21, <page>
               	ldr	x0, [x21, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x21, #0x38]
               	mov	x22, #0xd               // =13
               	str	x22, [x1]
               	mov	x0, #0x8e               // =142
               	str	x2, [sp, #0x38]
               	bl	<addr>
               	ldr	x2, [sp, #0x38]
               	ldr	x0, [x2, #0x58]
               	cmp	x0, #0x5d
               	b.ne	<addr>
               	bl	<addr>
               	cmp	x20, #0x2
               	b.le	<addr>
               	ldr	x0, [x21, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x21, #0x38]
               	str	x22, [x1]
               	ldr	x0, [x21, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x21, #0x38]
               	mov	x0, #0x1                // =1
               	str	x0, [x1]
               	ldr	x0, [x21, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x21, #0x38]
               	mov	x0, #0x8                // =8
               	str	x0, [x1]
               	ldr	x0, [x21, #0x38]
               	add	x1, x0, #0x8
               	str	x1, [x21, #0x38]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0x19               // =25
               	str	x0, [x2]
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	adrp	x0, <page>
               	sub	x1, x20, #0x2
               	str	x1, [x0, #0x68]
               	mov	x0, #0xa                // =10
               	mov	x3, #0x9                // =9
               	cmp	x1, #0x0
               	csel	x0, x3, x0, ne
               	b	<addr>
               	cmp	x20, #0x2
               	b.ge	<addr>
               	b	<addr>
               	str	x0, [x2]
               	adrp	x21, <page>
               	ldr	x1, [x21, #0x58]
               	cmp	x1, x23
               	b.ge	<addr>
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	str	x0, [x1]
               	bl	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x22
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x30]
               	add	x1, x1, #0x8
               	and	x1, x1, #0xfffffffffffffff8
               	str	x1, [x0, #0x30]
               	adrp	x0, <page>
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x68]
               	b	<addr>
               	cmp	x0, #0x8c
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	mov	x0, #0x1                // =1
               	str	x0, [x20, #0x68]
               	adrp	x21, <page>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x20, #0x68]
               	add	x0, x0, #0x2
               	str	x0, [x20, #0x68]
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x2, x1, #0x8
               	str	x2, [x0, #0x38]
               	mov	x1, #0x1                // =1
               	str	x1, [x2]
               	ldr	x2, [x0, #0x38]
               	add	x2, x2, #0x8
               	str	x2, [x0, #0x38]
               	adrp	x0, <page>
               	mov	x3, #0x8                // =8
               	ldr	x4, [x0, #0x68]
               	cmp	x4, #0x0
               	csel	x3, x3, x1, ne
               	str	x3, [x2]
               	str	x1, [x0, #0x68]
               	b	<addr>
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	str	xzr, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x22, [x0, #0x48]
               	bl	<addr>
               	adrp	x21, <page>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x38]
               	add	x2, x0, #0x8
               	str	x2, [x1, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x2]
               	add	x20, x20, #0x1
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x82
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x7                // =7
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	str	x20, [x1]
               	adrp	x0, <page>
               	ldr	x1, [x22, #0x20]
               	str	x1, [x0, #0x68]
               	b	<addr>
               	cmp	x0, #0x81
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x3                // =3
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	adrp	x0, <page>
               	str	x2, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	str	xzr, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x2, [x22, #0x28]
               	sub	x0, x0, x2
               	str	x0, [x1]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	adrp	x2, <page>
               	ldr	x0, [x22, #0x20]
               	str	x0, [x2, #0x68]
               	mov	x2, #0xa                // =10
               	mov	x3, #0x9                // =9
               	cmp	x0, #0x0
               	csel	x0, x3, x2, ne
               	str	x0, [x1]
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x83
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x21, <page>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x8a
               	b.eq	<addr>
               	cmp	x0, #0x86
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	ldr	x2, [x21, #0x58]
               	cmp	x2, #0x8a
               	csel	x20, x0, x1, eq
               	bl	<addr>
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	add	x20, x20, #0x2
               	ldr	x0, [x21, #0x58]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	str	x20, [x0, #0x68]
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x68]
               	cmp	x1, #0x1
               	b.le	<addr>
               	sub	x1, x1, #0x2
               	str	x1, [x0, #0x68]
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x38]
               	add	x2, x2, #0x8
               	str	x2, [x1, #0x38]
               	mov	x1, #0xa                // =10
               	mov	x3, #0x9                // =9
               	ldr	x0, [x0, #0x68]
               	cmp	x0, #0x0
               	csel	x0, x3, x1, ne
               	str	x0, [x2]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	ldr	x2, [x1]
               	cmp	x2, #0xa
               	b.eq	<addr>
               	ldr	x1, [x1]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	ldr	x1, [x0, #0x38]
               	sub	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x68]
               	add	x1, x1, #0x2
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	str	xzr, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x0, #0x11               // =17
               	str	x0, [x1]
               	adrp	x0, <page>
               	str	x2, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x7e
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x3, #-0x1               // =-1
               	str	x3, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x0, #0xf                // =15
               	str	x0, [x1]
               	adrp	x0, <page>
               	str	x2, [x0, #0x68]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	cmp	x0, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, #0x80
               	b.ne	<addr>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	neg	x0, x0
               	str	x0, [x1]
               	bl	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x68]
               	b	<addr>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #-0x1               // =-1
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0xa2
               	b.eq	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0xa3
               	b.ne	<addr>
               	ldr	x20, [x20, #0x58]
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x38]
               	ldr	x2, [x0]
               	cmp	x2, #0xa
               	b.ne	<addr>
               	mov	x2, #0xd                // =13
               	str	x2, [x0]
               	ldr	x0, [x1, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x1, #0x38]
               	mov	x2, #0xa                // =10
               	str	x2, [x0]
               	ldr	x0, [x1, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x1, #0x38]
               	mov	x2, #0xd                // =13
               	str	x2, [x0]
               	ldr	x0, [x1, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x1, #0x38]
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	ldr	x0, [x1, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x1, #0x38]
               	adrp	x3, <page>
               	mov	x4, #0x8                // =8
               	ldr	x5, [x3, #0x68]
               	cmp	x5, #0x2
               	csel	x2, x4, x2, gt
               	str	x2, [x0]
               	ldr	x0, [x1, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x1, #0x38]
               	mov	x2, #0x19               // =25
               	mov	x4, #0x1a               // =26
               	cmp	x20, #0xa2
               	csel	x2, x2, x4, eq
               	str	x2, [x0]
               	ldr	x0, [x1, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x1, #0x38]
               	mov	x1, #0xc                // =12
               	mov	x2, #0xb                // =11
               	ldr	x3, [x3, #0x68]
               	cmp	x3, #0x0
               	csel	x1, x2, x1, ne
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x1, #0x38]
               	ldr	x2, [x0]
               	cmp	x2, #0x9
               	b.ne	<addr>
               	mov	x2, #0xd                // =13
               	str	x2, [x0]
               	ldr	x0, [x1, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x1, #0x38]
               	mov	x2, #0x9                // =9
               	str	x2, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1

<stmt>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x89
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x4                // =4
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x20, x1, #0x8
               	str	x20, [x0, #0x38]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x87
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x18
               	str	x1, [x20]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x2                // =2
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x20, x1, #0x8
               	str	x20, [x0, #0x38]
               	bl	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	cmp	x0, #0x8d
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	add	x16, x0, #0x8
               	str	x16, [sp, #0x18]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x4                // =4
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x20, x1, #0x8
               	str	x20, [x0, #0x38]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x2                // =2
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	ldr	x17, [sp, #0x18]
               	str	x17, [x1]
               	ldr	x0, [x0, #0x38]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x8b
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x0, #0x8                // =8
               	str	x0, [x1]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x7d
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	ldr	x0, [x20, #0x58]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	brk	#0x1

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x25, x0, #0x1
               	add	x23, x1, #0x8
               	cmp	x25, #0x0
               	b.le	<addr>
               	ldr	x0, [x23]
               	ldrb	w1, [x0]
               	cmp	w1, #0x2d
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x1]
               	cmp	w0, #0x73
               	b.ne	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x80]
               	sub	x25, x25, #0x1
               	add	x23, x23, #0x8
               	cmp	x25, #0x0
               	b.le	<addr>
               	ldr	x0, [x23]
               	ldrb	w1, [x0]
               	cmp	w1, #0x2d
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x1]
               	cmp	w0, #0x64
               	b.ne	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x88]
               	sub	x25, x25, #0x1
               	add	x23, x23, #0x8
               	cmp	x25, #0x1
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x0, [x23]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x23]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	adrp	x1, <page>
               	str	x0, [x1, #0x50]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40000            // =262144
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	adrp	x1, <page>
               	str	x0, [x1, #0x38]
               	adrp	x1, <page>
               	str	x0, [x1, #0x40]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40000            // =262144
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	adrp	x1, <page>
               	str	x0, [x1, #0x30]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40000            // =262144
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	mov	x24, x0
               	cbnz	x24, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40000            // =262144
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40000            // =262144
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40000            // =262144
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40000            // =262144
               	bl	<addr>
               	adrp	x0, <page>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0, #0x20]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x86               // =134
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x87               // =135
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x88               // =136
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x89               // =137
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x8a               // =138
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x8b               // =139
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x8c               // =140
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x8d               // =141
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x1e               // =30
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x1f               // =31
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x20               // =32
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x21               // =33
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x22               // =34
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x23               // =35
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x24               // =36
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x25               // =37
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	mov	x1, #0x26               // =38
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x86               // =134
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x17, [x0, #0x48]
               	str	x17, [sp, #0x38]
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	adrp	x1, <page>
               	str	x0, [x1, #0x20]
               	adrp	x1, <page>
               	str	x0, [x1, #0x28]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40000            // =262144
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	mov	x2, #0x3ffff            // =262143
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.gt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	strb	wzr, [x1, x0]
               	mov	x0, x20
               	bl	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x78]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x21, #0x1               // =1
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	mov	x20, x21
               	b	<addr>
               	bl	<addr>
               	add	x20, x20, #0x2
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0, #0x18]
               	cbnz	x0, <addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	str	x20, [x1, #0x20]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, #0x28
               	b.ne	<addr>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x81               // =129
               	str	x2, [x1, #0x18]
               	ldr	x0, [x0, #0x48]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	mov	x22, x20
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	add	x20, x20, #0x2
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x18]
               	cmp	x2, #0x84
               	b.eq	<addr>
               	ldr	x2, [x1, #0x18]
               	str	x2, [x1, #0x30]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x84               // =132
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x20]
               	str	x2, [x1, #0x38]
               	ldr	x1, [x0, #0x48]
               	str	x20, [x1, #0x20]
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x28]
               	str	x2, [x1, #0x40]
               	ldr	x0, [x0, #0x48]
               	add	x20, x22, #0x1
               	str	x22, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x22, x22, #0x1
               	str	x22, [x0, #0x70]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x8a
               	b.eq	<addr>
               	ldr	x1, [x0, #0x58]
               	cmp	x1, #0x86
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	ldr	x0, [x0, #0x58]
               	cmp	x0, #0x8a
               	csel	x21, x1, x2, eq
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	mov	x20, x21
               	b	<addr>
               	bl	<addr>
               	add	x20, x20, #0x2
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x18]
               	cmp	x2, #0x84
               	b.eq	<addr>
               	ldr	x2, [x1, #0x18]
               	str	x2, [x1, #0x30]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x84               // =132
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x20]
               	str	x2, [x1, #0x38]
               	ldr	x1, [x0, #0x48]
               	str	x20, [x1, #0x20]
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x28]
               	str	x2, [x1, #0x40]
               	ldr	x0, [x0, #0x48]
               	add	x22, x22, #0x1
               	str	x22, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x2, #0x6                // =6
               	str	x2, [x1]
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	sub	x0, x22, x0
               	str	x0, [x1]
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x7d
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x38]
               	mov	x0, #0x8                // =8
               	str	x0, [x1]
               	adrp	x0, <page>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	str	x1, [x0, #0x48]
               	b	<addr>
               	ldr	x1, [x0, #0x48]
               	add	x1, x1, #0x48
               	str	x1, [x0, #0x48]
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1]
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x18]
               	cmp	x2, #0x84
               	b.ne	<addr>
               	ldr	x2, [x1, #0x30]
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x38]
               	str	x2, [x1, #0x20]
               	ldr	x1, [x0, #0x48]
               	ldr	x2, [x1, #0x40]
               	str	x2, [x1, #0x28]
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x83               // =131
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x30]
               	str	x2, [x1, #0x28]
               	ldr	x1, [x0, #0x30]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x30]
               	b	<addr>
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	cmp	x0, #0x88
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	cmp	x0, #0x85
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x22, [x0, #0x60]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x80               // =128
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0, #0x48]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0, #0x48]
               	add	x20, x22, #0x1
               	str	x22, [x0, #0x28]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x22, x20
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x16, [sp, #0x38]
               	ldr	x22, [x16, #0x28]
               	cbnz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x40000            // =262144
               	add	x24, x24, x0
               	sub	x0, x24, #0x8
               	mov	x1, #0x26               // =38
               	str	x1, [x0]
               	sub	x0, x0, #0x8
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	sub	x1, x0, #0x8
               	str	x25, [x1]
               	sub	x1, x1, #0x8
               	str	x23, [x1]
               	sub	x20, x1, #0x8
               	str	x0, [x20]
               	mov	x25, #0x0               // =0
               	ldr	x23, [x22], #0x8
               	add	x25, x25, #0x1
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x2, x23, x23, lsl #2
               	add	x2, x1, x2
               	mov	x1, x25
               	bl	<addr>
               	cmp	x23, #0x7
               	b.gt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x22]
               	bl	<addr>
               	cbnz	x23, <addr>
               	ldr	x0, [x22], #0x8
               	add	x21, x24, x0, lsl #3
               	b	<addr>
               	cmp	x23, #0x1
               	b.ne	<addr>
               	ldr	x21, [x22], #0x8
               	b	<addr>
               	cmp	x23, #0x2
               	b.ne	<addr>
               	ldr	x22, [x22]
               	b	<addr>
               	cmp	x23, #0x3
               	b.ne	<addr>
               	sub	x20, x20, #0x8
               	add	x0, x22, #0x8
               	str	x0, [x20]
               	ldur	x22, [x0, #-0x8]
               	b	<addr>
               	cmp	x23, #0x4
               	b.ne	<addr>
               	cbz	x21, <addr>
               	add	x22, x22, #0x8
               	b	<addr>
               	ldr	x22, [x22]
               	b	<addr>
               	cmp	x23, #0x5
               	b.ne	<addr>
               	cbz	x21, <addr>
               	ldr	x22, [x22]
               	b	<addr>
               	add	x22, x22, #0x8
               	b	<addr>
               	cmp	x23, #0x6
               	b.ne	<addr>
               	sub	x0, x20, #0x8
               	str	x24, [x0]
               	ldr	x1, [x22], #0x8
               	sub	x20, x0, x1, lsl #3
               	mov	x24, x0
               	b	<addr>
               	cmp	x23, #0x7
               	b.ne	<addr>
               	ldr	x0, [x22], #0x8
               	add	x20, x20, x0, lsl #3
               	b	<addr>
               	cmp	x23, #0x8
               	b.ne	<addr>
               	add	x0, x24, #0x8
               	ldur	x24, [x0, #-0x8]
               	add	x20, x0, #0x8
               	ldur	x22, [x20, #-0x8]
               	b	<addr>
               	cmp	x23, #0x9
               	b.ne	<addr>
               	ldr	x21, [x21]
               	b	<addr>
               	cmp	x23, #0xa
               	b.ne	<addr>
               	ldrb	w21, [x21]
               	b	<addr>
               	cmp	x23, #0xb
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	str	x21, [x0]
               	b	<addr>
               	cmp	x23, #0xc
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	strb	w21, [x0]
               	and	x21, x21, #0xff
               	b	<addr>
               	cmp	x23, #0xd
               	b.ne	<addr>
               	sub	x20, x20, #0x8
               	str	x21, [x20]
               	b	<addr>
               	cmp	x23, #0xe
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	orr	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0xf
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	eor	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x10
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	and	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x11
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	cmp	x0, x21
               	cset	x21, eq
               	b	<addr>
               	cmp	x23, #0x12
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	cmp	x0, x21
               	cset	x21, ne
               	b	<addr>
               	cmp	x23, #0x13
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	cmp	x0, x21
               	cset	x21, lt
               	b	<addr>
               	cmp	x23, #0x14
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	cmp	x0, x21
               	cset	x21, gt
               	b	<addr>
               	cmp	x23, #0x15
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	cmp	x0, x21
               	cset	x21, le
               	b	<addr>
               	cmp	x23, #0x16
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	cmp	x0, x21
               	cset	x21, ge
               	b	<addr>
               	cmp	x23, #0x17
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	lsl	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x18
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	asr	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x19
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	add	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x1a
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	sub	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x1b
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	mul	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x1c
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	sdiv	x21, x0, x21
               	b	<addr>
               	cmp	x23, #0x1d
               	b.ne	<addr>
               	ldr	x0, [x20], #0x8
               	sdiv	x17, x0, x21
               	msub	x21, x17, x21, x0
               	b	<addr>
               	cmp	x23, #0x1e
               	b.ne	<addr>
               	ldr	x0, [x20, #0x8]
               	ldr	x1, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	cmp	x23, #0x1f
               	b.ne	<addr>
               	ldr	x0, [x20, #0x10]
               	ldr	x1, [x20, #0x8]
               	ldr	x2, [x20]
               	bl	<addr>
               	mov	x21, x0
               	b	<addr>
               	cmp	x23, #0x20
               	b.ne	<addr>
               	ldr	x0, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	cmp	x23, #0x21
               	b.ne	<addr>
               	ldr	x0, [x22, #0x8]
               	add	x5, x20, x0, lsl #3
               	ldur	x0, [x5, #-0x8]
               	ldur	x1, [x5, #-0x10]
               	ldur	x2, [x5, #-0x18]
               	ldur	x3, [x5, #-0x20]
               	ldur	x4, [x5, #-0x28]
               	ldur	x5, [x5, #-0x30]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	cmp	x23, #0x22
               	b.ne	<addr>
               	ldr	x0, [x20]
               	bl	<addr>
               	mov	x21, x0
               	b	<addr>
               	cmp	x23, #0x23
               	b.ne	<addr>
               	ldr	x0, [x20]
               	bl	<addr>
               	b	<addr>
               	cmp	x23, #0x24
               	b.ne	<addr>
               	ldr	x0, [x20, #0x10]
               	ldr	x1, [x20, #0x8]
               	ldr	x2, [x20]
               	bl	<addr>
               	mov	x21, x0
               	b	<addr>
               	cmp	x23, #0x25
               	b.ne	<addr>
               	ldr	x0, [x20, #0x10]
               	ldr	x1, [x20, #0x8]
               	ldr	x2, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	b	<addr>
               	cmp	x23, #0x26
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x20]
               	mov	x2, x25
               	bl	<addr>
               	ldr	x0, [x20]
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	mov	x2, x25
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
