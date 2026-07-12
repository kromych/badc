
inline_two_word_struct_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	str	w0, [x1]
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mkpair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x10
               	str	x0, [x2]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x80
               	lsl	x3, x1, #4
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x1, x17
               	sub	x4, x29, #0xe8
               	str	w2, [x4]
               	sub	x2, x29, #0xe8
               	mov	x4, #0x1                // =1
               	str	x4, [x2, #0x8]
               	sub	x2, x29, #0xe8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	x1, x0, #0x0
               	sub	x0, x29, #0x80
               	ldrsw	x2, [x0, #0x10]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x10
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	sub	x0, x29, #0x80
               	ldrsw	x2, [x0, #0x20]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x20
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	sub	x0, x29, #0x80
               	ldrsw	x2, [x0, #0x30]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x30
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	sub	x0, x29, #0x80
               	ldrsw	x2, [x0, #0x40]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x40
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	sub	x0, x29, #0x80
               	ldrsw	x2, [x0, #0x50]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x50
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	sub	x0, x29, #0x80
               	ldrsw	x2, [x0, #0x60]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x60
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	sub	x0, x29, #0x80
               	ldrsw	x2, [x0, #0x70]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x70
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0xaaaa             // =43690
               	mov	x2, #0xbbbb             // =48059
               	sub	x3, x29, #0xf8
               	str	x0, [x3]
               	sub	x0, x29, #0xf8
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xf8
               	sub	x2, x29, #0xb8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0xb8
               	ldr	x2, [x0]
               	sub	x0, x29, #0xb8
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x0, x1, x0
               	mov	x17, #0x6785            // =26501
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
