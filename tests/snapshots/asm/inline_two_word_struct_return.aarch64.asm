
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
               	sub	sp, sp, #0x80
               	mov	x0, #0x0                // =0
               	mov	x2, #0xa                // =10
               	sub	x1, x29, #0x80
               	add	x1, x1, x0, lsl #4
               	mul	x3, x0, x2
               	mov	x4, #0x1                // =1
               	str	w3, [x1]
               	str	x4, [x1, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x78]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x70]
               	ldur	x2, [x29, #-0x68]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x60]
               	ldur	x2, [x29, #-0x58]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x50]
               	ldur	x2, [x29, #-0x48]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x40]
               	ldur	x2, [x29, #-0x38]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x30]
               	ldur	x2, [x29, #-0x28]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x20]
               	ldur	x2, [x29, #-0x18]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x8]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	mov	x17, #0x6665            // =26213
               	movk	x17, #0x1, lsl #16
               	add	x0, x0, x17
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	mov	x17, #0x6785            // =26501
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
