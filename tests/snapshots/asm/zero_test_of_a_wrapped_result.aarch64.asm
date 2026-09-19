
zero_test_of_a_wrapped_result.aarch64:	file format elf64-littleaarch64

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

<add_nz>:
               	add	x0, x0, x1
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<sub_z>:
               	sub	x0, x0, x1
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<mul_nz>:
               	mul	x0, x0, x1
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<uadd_nz>:
               	add	x0, x0, x1
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<umul_z>:
               	mul	x0, x0, x1
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<neg_nz>:
               	mov	x17, #-0x1              // =-1
               	mul	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	mov	x0, #-0x80000000        // =-2147483648
               	ldur	x1, [x29, #-0x30]
               	mov	x9, x1
               	mov	x1, x0
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7fffffff         // =2147483647
               	mov	x2, #0x1                // =1
               	ldur	x0, [x29, #-0x30]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #0x3                // =3
               	mov	x2, #-0x3               // =-3
               	ldur	x0, [x29, #-0x30]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbnz	w0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	ldur	x0, [x29, #-0x30]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x80000000        // =-2147483648
               	ldur	x1, [x29, #-0x28]
               	mov	x9, x1
               	mov	x1, x0
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #-0x80000000        // =-2147483648
               	mov	x2, #0x7fffffff         // =2147483647
               	ldur	x0, [x29, #-0x28]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #-0x80000000        // =-2147483648
               	ldur	x0, [x29, #-0x28]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10000            // =65536
               	ldur	x1, [x29, #-0x20]
               	mov	x9, x1
               	mov	x1, x0
               	blr	x9
               	cbnz	w0, <addr>
               	mov	x1, #0x3                // =3
               	mov	x2, #0x5                // =5
               	ldur	x0, [x29, #-0x20]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x7                // =7
               	ldur	x0, [x29, #-0x20]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	ldur	x1, [x29, #-0x18]
               	mov	x9, x1
               	mov	x1, x0
               	blr	x9
               	cbnz	w0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0xffffffff         // =4294967295
               	ldur	x0, [x29, #-0x18]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	ldur	x0, [x29, #-0x18]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10000            // =65536
               	ldur	x1, [x29, #-0x10]
               	mov	x9, x1
               	mov	x1, x0
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #0x3                // =3
               	mov	x2, #0x5                // =5
               	ldur	x0, [x29, #-0x10]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	ldur	x0, [x29, #-0x8]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cbnz	w0, <addr>
               	mov	x1, #-0x80000000        // =-2147483648
               	ldur	x0, [x29, #-0x8]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #0x5                // =5
               	ldur	x0, [x29, #-0x8]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
