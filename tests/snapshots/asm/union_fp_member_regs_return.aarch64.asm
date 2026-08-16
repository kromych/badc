
union_fp_member_regs_return.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	sub	x1, x29, #0x10
               	fmov	d16, x0
               	str	d16, [x1]
               	sub	x1, x29, #0x10
               	mov	x2, #0xb                // =11
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x40
               	ldr	d0, [x1]
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d16, x0
               	fneg	d0, d16
               	sub	x0, x29, #0x30
               	str	d0, [x0]
               	sub	x0, x29, #0x30
               	mov	x1, #0xb                // =11
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x80
               	ldr	d1, [x0]
               	fcmp	d1, d0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
