
mixed_sign_word_equality.aarch64:	file format elf64-littleaarch64

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

<u>:
               	ret

<s>:
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	ldr	w0, [x22, x20, lsl #2]
               	bl	<addr>
               	mov	x21, x0
               	ldr	w0, [x22, x20, lsl #2]
               	bl	<addr>
               	cmp	w21, #0x51
               	cset	x2, eq
               	ldr	w1, [x22, x20, lsl #2]
               	cmp	w1, #0x51
               	cset	x3, eq
               	cmp	w2, w3
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w21, w17
               	cset	x2, eq
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w1, w17
               	cset	x1, eq
               	cmp	w2, w1
               	b.ne	<addr>
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	cset	x3, eq
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	w2, [x1, x20, lsl #2]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	cset	x4, eq
               	cmp	w3, w4
               	b.ne	<addr>
               	cmp	w21, w0
               	b.ne	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	cset	x0, eq
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w2, w17
               	cset	x2, eq
               	cmp	w0, w2
               	b.ne	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w21, w17
               	cset	x0, eq
               	ldr	w1, [x1, x20, lsl #2]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w1, w17
               	cset	x1, eq
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x6
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
