
pthread_once_keys.aarch64:	file format elf64-littleaarch64

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

<init>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x24]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x24]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<call_once>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x24]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x28]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<destroy>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0x84]
               	add	x0, x0, #0x1
               	str	w0, [x1, #0x84]
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0x88]
               	ldrsw	x2, [x20]
               	add	x0, x0, x2
               	str	w0, [x1, #0x88]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	b	<addr>

<destroy_again>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0x8c]
               	add	x2, x0, #0x1
               	str	w2, [x1, #0x8c]
               	mov	x0, x2
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x68]
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	b	<addr>

<never>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x84]
               	add	x1, x1, #0x64
               	str	w1, [x0, #0x84]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x29, x30, [sp], #0x10
               	b	<addr>

<ends_process>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	brk	#0x1

<use_keys>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x60]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x60]
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x60]
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x64]
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x64]
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<no_value>:
               	mov	x0, #0x0                // =0
               	ret

<set_again>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, x0
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x68]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<outlives_key>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, x0
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x6c]
               	bl	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	adrp	x21, <page>
               	mov	x0, #0x1                // =1
               	str	w0, [x21, #0xc0]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	ldrsw	x0, [x21, #0xc0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	ldrsw	x0, [x21, #0xc0]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	sub	x0, x29, #0x40
               	add	x0, x0, x20, lsl #3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x21
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x8
               	b.lt	<addr>
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x8
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x24]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7c               // =124
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x28]
               	cbz	w0, <addr>
               	mov	x0, #0x7d               // =125
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7e               // =126
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x24]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7f               // =127
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	movk	x1, #0x2, lsl #32
               	str	x1, [x0]
               	mov	x1, #0x4                // =4
               	movk	x1, #0x8, lsl #32
               	str	x1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x83               // =131
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x84               // =132
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x85               // =133
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x86               // =134
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x87               // =135
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x60]
               	adrp	x1, <page>
               	ldr	w1, [x1, #0x64]
               	cmp	w0, w1
               	b.eq	<addr>
               	adrp	x2, <page>
               	ldr	w2, [x2, #0x68]
               	cmp	w1, w2
               	b.ne	<addr>
               	mov	x0, #0x88               // =136
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	add	x1, x21, #0xc
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8a               // =138
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	sub	x0, x29, #0x40
               	add	x0, x0, x1, lsl #3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x21, x1, lsl #2
               	str	x1, [sp, #0x18]
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x1, [sp, #0x18]
               	cbnz	x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, x2, lsl #3]
               	sub	x1, x29, #0x48
               	str	x2, [sp, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x2, [sp, #0x10]
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x48]
               	cbnz	x0, <addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x84]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x88]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	ldrsw	x0, [x0, #0x4]
               	orr	x0, x2, x0
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x60]
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0xc
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x95               // =149
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x0                // =0
               	ldur	x0, [x29, #-0x40]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x96               // =150
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x84]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x97               // =151
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x99               // =153
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x0                // =0
               	ldur	x0, [x29, #-0x40]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9a               // =154
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x8c]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9b               // =155
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9d               // =157
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xc0]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x6c]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa2               // =162
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0xc0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	ldur	x0, [x29, #-0x40]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa7               // =167
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x84]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa8               // =168
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x64]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb5               // =181
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x70]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb6               // =182
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x8f               // =143
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x8e               // =142
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x8c               // =140
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x7b               // =123
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x79               // =121
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
