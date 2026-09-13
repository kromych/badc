
inline_switch_jump_table.aarch64:	file format elf64-littleaarch64

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

<use>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x4, x0
               	sxtw	x1, w1
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sxtw	x2, w4
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	ldr	x3, [x0]
               	add	x3, x3, #0x1
               	str	x3, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x3, x3, x2
               	str	x3, [x0, #0x8]
               	sub	x3, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x6, [x0, #0x8]
               	str	x5, [x3]
               	str	x6, [x3, #0x8]
               	sub	x7, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x7]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x7, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x0, x4, #0x1
               	sxtw	x3, w0
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x7]
               	str	x10, [x0]
               	ldr	x10, [x7, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	ldr	x7, [x0]
               	add	x7, x7, #0x1
               	str	x7, [x0]
               	ldr	x7, [x0, #0x8]
               	sub	x3, x7, x3
               	str	x3, [x0, #0x8]
               	ldr	x3, [x0]
               	ldr	x7, [x0, #0x8]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x5, x17
               	add	x1, x1, x0
               	add	x0, x1, x6
               	mov	x17, #0xa               // =10
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	add	x1, x0, x7
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x0, #0x64               // =100
               	add	x0, x1, x0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x65               // =101
               	b	<addr>
               	mov	x0, #0x66               // =102
               	b	<addr>
               	mov	x0, #0x67               // =103
               	b	<addr>
               	mov	x0, #0x68               // =104
               	b	<addr>
               	mov	x0, #0x69               // =105
               	b	<addr>
               	mov	x0, #0x6a               // =106
               	b	<addr>
               	mov	x0, #0x6b               // =107
               	b	<addr>
               	mov	x0, #0x6c               // =108
               	b	<addr>
               	mov	x0, #0x6d               // =109
               	b	<addr>
               	mov	x0, #0x6e               // =110
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	ldr	x7, [x0]
               	add	x7, x7, #0x8
               	str	x7, [x0]
               	b	<addr>
               	ldr	x7, [x0]
               	add	x7, x7, #0xf
               	str	x7, [x0]
               	b	<addr>
               	ldr	x7, [x0]
               	add	x7, x7, #0x16
               	str	x7, [x0]
               	b	<addr>
               	ldr	x7, [x0]
               	add	x7, x7, #0x1d
               	str	x7, [x0]
               	b	<addr>
               	ldr	x7, [x0]
               	add	x7, x7, #0x24
               	str	x7, [x0]
               	b	<addr>
               	ldr	x7, [x0]
               	add	x7, x7, #0x2b
               	str	x7, [x0]
               	b	<addr>
               	ldr	x7, [x0]
               	add	x7, x7, #0x32
               	str	x7, [x0]
               	b	<addr>
               	sub	x7, x29, #0x10
               	ldr	x8, [x7]
               	add	x8, x8, #0x39
               	str	x8, [x7]
               	b	<addr>
               	sub	x7, x29, #0x10
               	ldr	x8, [x7]
               	add	x8, x8, #0x40
               	str	x8, [x7]
               	b	<addr>
               	sub	x7, x29, #0x10
               	ldr	x8, [x7]
               	add	x8, x8, #0x47
               	str	x8, [x7]
               	b	<addr>
               	sub	x7, x29, #0x10
               	ldr	x8, [x7]
               	add	x8, x8, #0x4e
               	str	x8, [x7]
               	b	<addr>
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x3, [x0]
               	str	x3, [x0, #0x8]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x8
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0xf
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x16
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x1d
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x24
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x2b
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x32
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x39
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x40
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x47
               	str	x3, [x0]
               	b	<addr>
               	ldr	x3, [x0]
               	add	x3, x3, #0x4e
               	str	x3, [x0]
               	b	<addr>
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x3, [x0]
               	str	x3, [x0, #0x8]
               	b	<addr>
               	mov	x1, #0x5                // =5
               	b	<addr>
               	mov	x1, #0x8                // =8
               	b	<addr>
               	mov	x1, #0xb                // =11
               	b	<addr>
               	mov	x1, #0xe                // =14
               	b	<addr>
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x1, #0x14               // =20
               	b	<addr>
               	mov	x1, #0x17               // =23
               	b	<addr>
               	mov	x1, #0x1a               // =26
               	b	<addr>
               	mov	x1, #0x1d               // =29
               	b	<addr>
               	mov	x1, #0x20               // =32
               	b	<addr>
               	mov	x1, #0x23               // =35
               	b	<addr>
               	mov	x1, #0x3e8              // =1000
               	b	<addr>

<expect>:
               	cmp	w1, #0x0
               	b.lt	<addr>
               	cmp	w1, #0xc
               	cset	x2, lt
               	cbz	x2, <addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x2
               	sxtw	x3, w1
               	add	x1, x0, #0x1
               	sxtw	x2, w1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	cmp	w0, #0xc
               	cset	x1, lt
               	cbz	x1, <addr>
               	mov	x17, #0x7               // =7
               	mul	x1, x0, x17
               	add	x1, x1, #0x64
               	add	x1, x1, #0x1
               	sxtw	x4, w1
               	mov	x1, #0xc8               // =200
               	sub	x1, x1, x0
               	sxtw	x1, w1
               	cmp	w2, #0x0
               	b.lt	<addr>
               	cmp	w2, #0xc
               	cset	x5, lt
               	cbz	x5, <addr>
               	mov	x17, #0x7               // =7
               	mul	x5, x2, x17
               	sxtw	x5, w5
               	add	x5, x4, x5
               	add	x5, x5, #0x1
               	sub	x2, x1, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	add	x3, x3, x4
               	add	x1, x3, x1
               	mov	x17, #0xa               // =10
               	mul	x3, x5, x17
               	add	x1, x1, x3
               	add	x2, x1, x2
               	cmp	w0, #0x0
               	b.lt	<addr>
               	cmp	w0, #0xa
               	cset	x1, le
               	cbz	x1, <addr>
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	x0, x2, x0
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x5, x2
               	b	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x4, x1
               	b	<addr>
               	mov	x3, #0x3e8              // =1000
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0xfffe            // =65534
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	b	<addr>
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0xf
               	b.lt	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	cmp	w21, #0xf
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
