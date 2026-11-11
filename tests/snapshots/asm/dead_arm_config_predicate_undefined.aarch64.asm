
dead_arm_config_predicate_undefined.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	ldr	x0, [x0]
               	and	x1, x0, #0x1
               	add	x1, x1, #0xa
               	tst	x0, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x0, x2, x3, ne
               	add	x0, x1, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	tst	x2, #0x8
               	csel	x2, x0, x1, ne
               	add	x2, x2, #0xb
               	add	x2, x2, #0xa
               	mov	x3, #0x2                // =2
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	tst	x3, #0x8
               	csel	x3, x0, x1, ne
               	add	x3, x3, #0xa
               	add	x2, x2, x3
               	mov	x3, #0x3                // =3
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	tst	x3, #0x8
               	csel	x3, x0, x1, ne
               	add	x3, x3, #0xb
               	add	x2, x2, x3
               	mov	x3, #0x4                // =4
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	tst	x3, #0x8
               	csel	x1, x0, x1, ne
               	add	x1, x1, #0xa
               	add	x1, x2, x1
               	mov	x2, #0x5                // =5
               	stur	x2, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	tst	x2, #0x8
               	mov	x3, #0x0                // =0
               	csel	x0, x0, x3, ne
               	add	x0, x0, #0xb
               	add	x0, x1, x0
               	mov	x1, #0x6                // =6
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xa
               	add	x0, x0, x1
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xb
               	add	x0, x0, x1
               	mov	x1, #0x8                // =8
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xa
               	add	x0, x0, x1
               	mov	x1, #0x9                // =9
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xb
               	add	x0, x0, x1
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xa
               	add	x0, x0, x1
               	mov	x1, #0xb                // =11
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xb
               	add	x0, x0, x1
               	mov	x1, #0xc                // =12
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xa
               	add	x0, x0, x1
               	mov	x1, #0xd                // =13
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xb
               	add	x0, x0, x1
               	mov	x1, #0xe                // =14
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xa
               	add	x0, x0, x1
               	mov	x1, #0xf                // =15
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	tst	x1, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x1, x2, x3, ne
               	add	x1, x1, #0xb
               	add	x0, x0, x1
               	cmp	w0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
