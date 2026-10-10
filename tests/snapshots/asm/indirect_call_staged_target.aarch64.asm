
indirect_call_staged_target.aarch64:	file format elf64-littleaarch64

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

<weigh17>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x6, x17
               	add	x0, x0, x1
               	lsl	x1, x7, #3
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x10]
               	mov	x17, #0x9               // =9
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x18]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x20]
               	mov	x17, #0xb               // =11
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x28]
               	mov	x17, #0xc               // =12
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x30]
               	mov	x17, #0xd               // =13
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x38]
               	mov	x17, #0xe               // =14
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x40]
               	mov	x17, #0xf               // =15
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x48]
               	lsl	x1, x1, #4
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x50]
               	mov	x17, #0x11              // =17
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<through>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x0, [sp, #0xa8]
               	add	x0, x1, x2
               	sub	x3, x1, x2
               	mul	x4, x1, x2
               	add	x5, x1, #0x1
               	add	x6, x2, #0x1
               	add	x7, x1, #0x2
               	add	x8, x2, #0x2
               	add	x16, x1, #0x3
               	str	x16, [sp, #0xa0]
               	add	x16, x2, #0x3
               	str	x16, [sp, #0x98]
               	add	x16, x1, #0x4
               	str	x16, [sp, #0x90]
               	add	x16, x2, #0x4
               	str	x16, [sp, #0x88]
               	add	x16, x1, #0x5
               	str	x16, [sp, #0x80]
               	add	x16, x2, #0x5
               	str	x16, [sp, #0x78]
               	add	x16, x1, #0x6
               	str	x16, [sp, #0x70]
               	add	x16, x2, #0x6
               	str	x16, [sp, #0x68]
               	ldr	x16, [sp, #0xa8]
               	str	x16, [sp, #0x50]
               	str	x8, [sp]
               	ldr	x16, [sp, #0xa0]
               	str	x16, [sp, #0x8]
               	ldr	x16, [sp, #0x98]
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x90]
               	str	x16, [sp, #0x18]
               	ldr	x16, [sp, #0x88]
               	str	x16, [sp, #0x20]
               	ldr	x16, [sp, #0x80]
               	str	x16, [sp, #0x28]
               	ldr	x16, [sp, #0x78]
               	str	x16, [sp, #0x30]
               	ldr	x16, [sp, #0x70]
               	str	x16, [sp, #0x38]
               	ldr	x16, [sp, #0x68]
               	str	x16, [sp, #0x40]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	ldr	x16, [sp, #0x50]
               	blr	x16
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x3                // =3
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x4bf
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
