
union_fp_member_regs_return.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x10
               	str	d0, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0xb                // =11
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mk_i>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	str	w0, [x1]
               	sub	x0, x29, #0x10
               	mov	x1, #0x16               // =22
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
               	sub	sp, sp, #0xa0
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	sub	x1, x29, #0x78
               	fmov	d16, x0
               	str	d16, [x1]
               	sub	x1, x29, #0x78
               	mov	x2, #0xb                // =11
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x78
               	sub	x2, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x10
               	ldr	d0, [x1]
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	sub	x1, x29, #0x88
               	str	w0, [x1]
               	sub	x0, x29, #0x88
               	mov	x1, #0x16               // =22
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	mov	x17, #0x1234            // =4660
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d16, x0
               	fneg	d0, d16
               	sub	x0, x29, #0x98
               	str	d0, [x0]
               	sub	x0, x29, #0x98
               	mov	x1, #0xb                // =11
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x98
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x50
               	ldr	d1, [x0]
               	fcmp	d1, d0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
