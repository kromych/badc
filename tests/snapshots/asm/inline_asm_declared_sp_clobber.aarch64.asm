
inline_asm_declared_sp_clobber.aarch64:	file format elf64-littleaarch64

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

<mix>:
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	ret

<moved>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	add	x21, x0, #0x1
               	mov	x17, #0x3               // =3
               	mul	x22, x0, x17
               	mov	x17, #0x55              // =85
               	eor	x23, x0, x17
               	mul	x24, x0, x0
               	sub	x25, x0, #0x9
               	lsl	x26, x0, #4
               	mov	x17, #0x7               // =7
               	mul	x1, x0, x17
               	add	x27, x1, #0x2
               	mov	x17, #0x1234            // =4660
               	eor	x28, x0, x17
               	mov	x17, #0xb               // =11
               	mul	x16, x0, x17
               	stur	x16, [x29, #-0x8]
               	add	x16, x0, #0x64
               	stur	x16, [x29, #-0x10]
               	mov	x17, #0xd               // =13
               	mul	x1, x0, x17
               	sub	x16, x1, #0x5
               	stur	x16, [x29, #-0x18]
               	lsl	x16, x0, #9
               	stur	x16, [x29, #-0x20]
               	mov	x17, #0x7777            // =30583
               	eor	x16, x0, x17
               	stur	x16, [x29, #-0x28]
               	mov	x17, #0x11              // =17
               	mul	x16, x0, x17
               	stur	x16, [x29, #-0x30]
               	mov	x17, #0x3039            // =12345
               	add	x16, x0, x17
               	stur	x16, [x29, #-0x38]
               	mov	x17, #0x13              // =19
               	mul	x1, x0, x17
               	add	x16, x1, #0x3
               	stur	x16, [x29, #-0x40]
               	bl	<addr>
               	mov	x20, x0
               	sub	sp, sp, #0x10
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x20, x0
               	add	x1, x21, x22, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x2, x23, x17
               	add	x1, x1, x2
               	add	x1, x1, x24, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x2, x25, x17
               	add	x1, x1, x2
               	mov	x17, #0x6               // =6
               	mul	x2, x26, x17
               	add	x1, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x2, x27, x17
               	add	x1, x1, x2
               	add	x1, x1, x28, lsl #3
               	ldur	x16, [x29, #-0x8]
               	mov	x17, #0x9               // =9
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldur	x16, [x29, #-0x10]
               	mov	x17, #0xa               // =10
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldur	x16, [x29, #-0x18]
               	mov	x17, #0xb               // =11
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldur	x16, [x29, #-0x20]
               	mov	x17, #0xc               // =12
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldur	x16, [x29, #-0x28]
               	mov	x17, #0xd               // =13
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldur	x16, [x29, #-0x30]
               	mov	x17, #0xe               // =14
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldur	x16, [x29, #-0x38]
               	mov	x17, #0xf               // =15
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldur	x17, [x29, #-0x40]
               	add	x1, x1, x17, lsl #4
               	add	x0, x1, x0
               	sub	sp, x29, #0x90
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret

<kept>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	add	x21, x0, #0x1
               	mov	x17, #0x3               // =3
               	mul	x22, x0, x17
               	mov	x17, #0x55              // =85
               	eor	x23, x0, x17
               	mul	x24, x0, x0
               	sub	x25, x0, #0x9
               	lsl	x26, x0, #4
               	mov	x17, #0x7               // =7
               	mul	x1, x0, x17
               	add	x27, x1, #0x2
               	mov	x17, #0x1234            // =4660
               	eor	x28, x0, x17
               	mov	x17, #0xb               // =11
               	mul	x16, x0, x17
               	str	x16, [sp, #0x88]
               	add	x16, x0, #0x64
               	str	x16, [sp, #0x80]
               	mov	x17, #0xd               // =13
               	mul	x1, x0, x17
               	sub	x16, x1, #0x5
               	str	x16, [sp, #0x78]
               	lsl	x16, x0, #9
               	str	x16, [sp, #0x70]
               	mov	x17, #0x7777            // =30583
               	eor	x16, x0, x17
               	str	x16, [sp, #0x68]
               	mov	x17, #0x11              // =17
               	mul	x16, x0, x17
               	str	x16, [sp, #0x60]
               	mov	x17, #0x3039            // =12345
               	add	x16, x0, x17
               	str	x16, [sp, #0x58]
               	mov	x17, #0x13              // =19
               	mul	x1, x0, x17
               	add	x16, x1, #0x3
               	str	x16, [sp, #0x50]
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x20, x0
               	add	x1, x21, x22, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x2, x23, x17
               	add	x1, x1, x2
               	add	x1, x1, x24, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x2, x25, x17
               	add	x1, x1, x2
               	mov	x17, #0x6               // =6
               	mul	x2, x26, x17
               	add	x1, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x2, x27, x17
               	add	x1, x1, x2
               	add	x1, x1, x28, lsl #3
               	ldr	x16, [sp, #0x88]
               	mov	x17, #0x9               // =9
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldr	x16, [sp, #0x80]
               	mov	x17, #0xa               // =10
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldr	x16, [sp, #0x78]
               	mov	x17, #0xb               // =11
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldr	x16, [sp, #0x70]
               	mov	x17, #0xc               // =12
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldr	x16, [sp, #0x68]
               	mov	x17, #0xd               // =13
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0xe               // =14
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldr	x16, [sp, #0x58]
               	mov	x17, #0xf               // =15
               	mul	x2, x16, x17
               	add	x1, x1, x2
               	ldr	x17, [sp, #0x50]
               	add	x1, x1, x17, lsl #4
               	add	x0, x1, x0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x17, #0x5               // =5
               	mul	x21, x1, x17
               	ldr	x1, [x0]
               	mov	x17, #0x99              // =153
               	eor	x22, x1, x17
               	ldr	x1, [x0]
               	add	x23, x1, #0x4d
               	ldr	x1, [x0]
               	mov	x17, #0x3               // =3
               	mul	x24, x1, x17
               	ldr	x20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	mov	x25, x0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x25, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	cmp	x21, #0x23
               	b.ne	<addr>
               	cmp	x22, #0x9e
               	b.ne	<addr>
               	cmp	x23, #0x54
               	b.ne	<addr>
               	cmp	x24, #0x15
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	add	x0, x20, #0x1
               	bl	<addr>
               	mov	x21, x0
               	add	x0, x20, #0x1
               	bl	<addr>
               	cmp	x21, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
