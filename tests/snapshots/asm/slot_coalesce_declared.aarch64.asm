
slot_coalesce_declared.aarch64:	file format elf64-littleaarch64

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

<build>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x48
               	str	x8, [x16]
               	mov	x2, #0xa                // =10
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	x2, [x0]
               	mov	x1, #0xb                // =11
               	str	x1, [x0, #0x8]
               	mov	x1, #0xc                // =12
               	str	x1, [x0, #0x10]
               	mov	x1, #0xd                // =13
               	str	x1, [x0, #0x18]
               	mov	x1, #0xe                // =14
               	str	x1, [x0, #0x20]
               	mov	x1, #0xf                // =15
               	str	x1, [x0, #0x28]
               	mov	x1, #0x10               // =16
               	str	x1, [x0, #0x30]
               	str	x2, [x0, #0x38]
               	mov	x16, x0
               	sub	x17, x29, #0x48
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	ldr	x0, [x16, #0x20]
               	str	x0, [x17, #0x20]
               	ldr	x0, [x16, #0x28]
               	str	x0, [x17, #0x28]
               	ldr	x0, [x16, #0x30]
               	str	x0, [x17, #0x30]
               	ldr	x0, [x16, #0x38]
               	str	x0, [x17, #0x38]
               	mov	x0, x17
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x100]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x2, x0, x17
               	add	x3, x2, #0x7
               	add	x1, x1, x3
               	add	x3, x0, x0
               	add	x3, x3, x0
               	sub	x2, x3, x2
               	add	x2, x1, x2
               	mov	x17, #0x9               // =9
               	mul	x1, x0, x17
               	sub	x1, x1, x1
               	add	x1, x2, x1
               	add	x0, x0, #0x1
               	cmp	x0, #0x32
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x3, x0, x17
               	add	x3, x3, #0x7
               	add	x2, x2, x3
               	add	x0, x0, #0x1
               	cmp	x0, #0x32
               	b.lt	<addr>
               	cmp	x1, x2
               	cset	x1, eq
               	mov	x0, #0xabcd             // =43981
               	movk	x0, #0x1234, lsl #16
               	stur	x0, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	ldr	x2, [x0]
               	mov	x17, #0xfeed            // =65261
               	eor	x2, x2, x17
               	str	x2, [x0]
               	sxtw	x0, w1
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x48]
               	mov	x17, #0x5520            // =21792
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x7b               // =123
               	sub	x0, x29, #0x60
               	str	x2, [x0]
               	mov	x2, #0x552e             // =21806
               	str	x2, [x0, #0x8]
               	mov	x2, #0x84               // =132
               	str	x2, [x0, #0x10]
               	mov	x2, #0x171              // =369
               	str	x2, [x0, #0x18]
               	sub	x2, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x18]
               	add	x0, x1, x0
               	mov	x17, #0x579e            // =22430
               	cmp	x0, x17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x21, #0x1               // =1
               	mov	x0, #0xa                // =10
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sxtw	x0, w21
               	cbz	x0, <addr>
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x18]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x20]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x28]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x30]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x38]
               	add	x0, x1, x0
               	cmp	x0, #0x65
               	cset	x20, eq
               	sxtw	x0, w20
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	b	<addr>
               	mov	x21, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x1, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
