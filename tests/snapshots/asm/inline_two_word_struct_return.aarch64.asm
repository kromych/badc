
inline_two_word_struct_return.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x90
               	lsl	x3, x1, #4
               	add	x4, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x3, x1, x17
               	sub	x2, x29, #0xa0
               	str	w3, [x2]
               	mov	x3, #0x1                // =1
               	str	x3, [x2, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x4]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x90
               	add	x1, x0, #0x0
               	ldrsw	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x2, x1
               	add	x2, x1, #0x0
               	ldrsw	x3, [x0, #0x10]
               	add	x1, x0, #0x10
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x2, x2, x1
               	ldrsw	x3, [x0, #0x20]
               	add	x1, x0, #0x20
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x2, x2, x1
               	ldrsw	x3, [x0, #0x30]
               	add	x1, x0, #0x30
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x2, x2, x1
               	ldrsw	x3, [x0, #0x40]
               	add	x1, x0, #0x40
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x2, x2, x1
               	ldrsw	x3, [x0, #0x50]
               	add	x1, x0, #0x50
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x2, x2, x1
               	ldrsw	x3, [x0, #0x60]
               	add	x1, x0, #0x60
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x1, x2, x1
               	ldrsw	x2, [x0, #0x70]
               	add	x0, x0, #0x70
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x0, x1, x0
               	mov	x17, #0x6665            // =26213
               	movk	x17, #0x1, lsl #16
               	add	x0, x0, x17
               	mov	x17, #0x6785            // =26501
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
