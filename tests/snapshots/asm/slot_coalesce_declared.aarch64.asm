
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
               	str	x20, [sp, #-0xe0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	mov	x3, #0x3                // =3
               	mov	x4, #0x9                // =9
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mul	x2, x0, x3
               	add	x5, x2, #0x7
               	add	x1, x1, x5
               	add	x5, x0, x0
               	add	x5, x5, x0
               	sub	x2, x5, x2
               	add	x2, x1, x2
               	mul	x1, x0, x4
               	sub	x1, x1, x1
               	add	x1, x2, x1
               	add	x0, x0, #0x1
               	cmp	x0, #0x32
               	b.lt	<addr>
               	mov	x3, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	mul	x4, x0, x3
               	add	x4, x4, #0x7
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	cmp	x0, #0x32
               	b.lt	<addr>
               	cmp	x1, x2
               	cset	x1, eq
               	mov	x0, #0xabcd             // =43981
               	movk	x0, #0x1234, lsl #16
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	ldr	x2, [x0]
               	mov	x17, #0xfeed            // =65261
               	eor	x2, x2, x17
               	str	x2, [x0]
               	sxtw	x0, w1
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x28]
               	mov	x17, #0x5520            // =21792
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x20, #0x1               // =1
               	mov	x0, #0xa                // =10
               	sub	x8, x29, #0xa0
               	bl	<addr>
               	sub	x0, x29, #0xa0
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	ldr	x4, [x0, #0x10]
               	ldr	x5, [x0, #0x18]
               	ldr	x6, [x0, #0x20]
               	ldr	x7, [x0, #0x28]
               	ldr	x8, [x0, #0x30]
               	ldr	x0, [x0, #0x38]
               	sxtw	x9, w20
               	mov	x1, #0x0                // =0
               	cbz	x9, <addr>
               	stur	x6, [x29, #-0x40]
               	stur	x7, [x29, #-0x38]
               	stur	x8, [x29, #-0x30]
               	stur	x0, [x29, #-0x28]
               	add	x0, x2, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	ldur	x2, [x29, #-0x40]
               	add	x0, x0, x2
               	ldur	x2, [x29, #-0x38]
               	add	x0, x0, x2
               	ldur	x2, [x29, #-0x30]
               	add	x0, x0, x2
               	ldur	x2, [x29, #-0x28]
               	add	x0, x0, x2
               	cmp	x0, #0x65
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xe0
               	ret
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xe0
               	ret
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
