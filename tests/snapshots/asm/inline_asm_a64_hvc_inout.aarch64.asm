
inline_asm_a64_hvc_inout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x1, #0x84000000         // =2214592512
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x4, #0x3                // =3
               	mov	x5, #0x4                // =4
               	mov	x6, #0x5                // =5
               	mov	x7, #0x6                // =6
               	mov	x8, #0x7                // =7
               	sub	x9, x29, #0x40
               	sub	x10, x29, #0x38
               	sub	x11, x29, #0x30
               	sub	x12, x29, #0x28
               	sub	sp, sp, #0xa0
               	str	x0, [sp, #0x60]
               	str	x1, [sp, #0x68]
               	str	x2, [sp, #0x70]
               	str	x3, [sp, #0x78]
               	str	x4, [sp, #0x80]
               	str	x5, [sp, #0x88]
               	str	x6, [sp, #0x90]
               	str	x7, [sp, #0x98]
               	str	x9, [sp]
               	str	x10, [sp, #0x8]
               	str	x11, [sp, #0x10]
               	str	x12, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x3, [sp, #0x30]
               	str	x4, [sp, #0x38]
               	str	x5, [sp, #0x40]
               	str	x6, [sp, #0x48]
               	str	x7, [sp, #0x50]
               	str	x8, [sp, #0x58]
               	ldr	x0, [sp, #0x20]
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x30]
               	ldr	x3, [sp, #0x38]
               	ldr	x4, [sp, #0x40]
               	ldr	x5, [sp, #0x48]
               	ldr	x6, [sp, #0x50]
               	ldr	x7, [sp, #0x58]
               	hvc	#0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x16, [sp, #0x10]
               	str	x2, [x16]
               	ldr	x16, [sp, #0x18]
               	str	x3, [x16]
               	ldr	x0, [sp, #0x60]
               	ldr	x1, [sp, #0x68]
               	ldr	x2, [sp, #0x70]
               	ldr	x3, [sp, #0x78]
               	ldr	x4, [sp, #0x80]
               	ldr	x5, [sp, #0x88]
               	ldr	x6, [sp, #0x90]
               	ldr	x7, [sp, #0x98]
               	add	sp, sp, #0xa0
               	mov	x1, #0x84000000         // =2214592512
               	mov	x2, #0x1                // =1
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x58
               	sub	x5, x29, #0x50
               	sub	x6, x29, #0x48
               	sub	sp, sp, #0x50
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	str	x3, [sp, #0x48]
               	str	x3, [sp]
               	str	x4, [sp, #0x8]
               	str	x5, [sp, #0x10]
               	str	x6, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x1, [sp, #0x28]
               	smc	#0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x16, [sp, #0x10]
               	str	x2, [x16]
               	ldr	x16, [sp, #0x18]
               	str	x3, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	x1, [sp, #0x38]
               	ldr	x2, [sp, #0x40]
               	ldr	x3, [sp, #0x48]
               	add	sp, sp, #0x50
               	ldur	x1, [x29, #-0x60]
               	sxtw	x0, w1
               	sxtw	x0, w0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
