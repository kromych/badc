
inline_asm_a64_hvc_inout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<hvc_call>:
               	sub	sp, sp, #0x10
               	ldr	x16, [sp, #0x10]
               	str	x16, [sp]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x8, x29, #0x20
               	sub	x9, x29, #0x18
               	sub	x10, x29, #0x10
               	sub	x11, x29, #0x8
               	sub	sp, sp, #0xa0
               	str	x0, [sp, #0x60]
               	str	x1, [sp, #0x68]
               	str	x2, [sp, #0x70]
               	str	x3, [sp, #0x78]
               	str	x4, [sp, #0x80]
               	str	x5, [sp, #0x88]
               	str	x6, [sp, #0x90]
               	str	x7, [sp, #0x98]
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	str	x10, [sp, #0x10]
               	str	x11, [sp, #0x18]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	str	x2, [sp, #0x30]
               	str	x3, [sp, #0x38]
               	str	x4, [sp, #0x40]
               	str	x5, [sp, #0x48]
               	str	x6, [sp, #0x50]
               	str	x7, [sp, #0x58]
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
               	ldur	x0, [x29, #0x90]
               	ldur	x1, [x29, #-0x20]
               	str	x1, [x0]
               	ldur	x1, [x29, #-0x18]
               	str	x1, [x0, #0x8]
               	ldur	x1, [x29, #-0x10]
               	str	x1, [x0, #0x10]
               	ldur	x1, [x29, #-0x8]
               	str	x1, [x0, #0x18]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x90
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x20, #0x84000000        // =2214592512
               	mov	x21, #0x1               // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	mov	x5, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x7                // =7
               	sub	x0, x29, #0x20
               	sub	sp, sp, #0x10
               	str	x0, [sp]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	sp, sp, #0x10
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x38
               	sub	x3, x29, #0x30
               	sub	x4, x29, #0x28
               	sub	sp, sp, #0x50
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	str	x3, [sp, #0x48]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	str	x3, [sp, #0x10]
               	str	x4, [sp, #0x18]
               	str	x20, [sp, #0x20]
               	str	x21, [sp, #0x28]
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
               	ldur	x1, [x29, #-0x40]
               	str	x1, [x0]
               	ldur	x1, [x29, #-0x38]
               	str	x1, [x0, #0x8]
               	ldur	x1, [x29, #-0x30]
               	str	x1, [x0, #0x10]
               	ldur	x1, [x29, #-0x28]
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
