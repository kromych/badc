
call_result_in_place.aarch64:	file format elf64-littleaarch64

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

<make>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x28
               	str	x8, [x16]
               	mov	x1, x0
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	str	x1, [x0]
               	add	x2, x1, #0x1
               	str	x2, [x0, #0x8]
               	add	x2, x1, #0x2
               	str	x2, [x0, #0x10]
               	add	x1, x1, #0x3
               	str	x1, [x0, #0x18]
               	mov	x16, x0
               	sub	x17, x29, #0x28
               	ldr	x17, [x17]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<makep>:
               	lsl	x1, x0, #1
               	ret

<makeq>:
               	neg	x1, x0
               	mov	w0, w0
               	mov	w1, w1
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	ret

<rotate_global>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x28
               	str	x8, [x16]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldr	x2, [x2, #0x18]
               	str	x2, [x0]
               	ldr	x2, [x1]
               	ldr	x2, [x2]
               	str	x2, [x0, #0x8]
               	ldr	x2, [x1]
               	ldr	x2, [x2, #0x8]
               	str	x2, [x0, #0x10]
               	ldr	x1, [x1]
               	ldr	x1, [x1, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x16, x0
               	sub	x17, x29, #0x28
               	ldr	x17, [x17]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<rotate_arg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x28
               	str	x8, [x16]
               	mov	x1, x0
               	sub	x0, x29, #0x20
               	ldr	x2, [x1, #0x18]
               	str	x2, [x0]
               	ldr	x2, [x1]
               	str	x2, [x0, #0x8]
               	ldr	x2, [x1, #0x8]
               	str	x2, [x0, #0x10]
               	ldr	x1, [x1, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x16, x0
               	sub	x17, x29, #0x28
               	ldr	x17, [x17]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<clobber_global>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x28
               	str	x8, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x64               // =100
               	str	x2, [x1]
               	ldr	x0, [x0]
               	mov	x1, #0x190              // =400
               	str	x1, [x0, #0x18]
               	mov	x0, #0x7                // =7
               	sub	x8, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	sub	x17, x29, #0x28
               	ldr	x17, [x17]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<swap_global>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x1, #0x8]
               	ldr	x1, [x1]
               	ret

<use>:
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret

<usep>:
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret

<fresh>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x1                // =1
               	sub	x8, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	ldr	x0, [x1]
               	ldr	x2, [x1, #0x8]
               	ldr	x3, [x1, #0x10]
               	ldr	x4, [x1, #0x18]
               	cmp	x0, #0x1
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	cmp	x2, #0x2
               	cset	x2, eq
               	cbz	x2, <addr>
               	cmp	x3, #0x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	cmp	x4, #0x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x10e1            // =4321
               	cmp	x0, x17
               	cset	x0, eq
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>

<assign_local>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x5                // =5
               	sub	x8, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	mov	x17, #0x223d            // =8765
               	cmp	x0, x17
               	cset	x0, eq
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<through_pointer>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x0, #0x9                // =9
               	sub	x8, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x20]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x20, #0x10]
               	ldr	x0, [x20]
               	cmp	x0, #0x9
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x1, [x20, #0x8]
               	cmp	x1, #0xa
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x1, [x20, #0x10]
               	cmp	x1, #0xb
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x0, [x20, #0x18]
               	cmp	x0, #0xc
               	cset	x0, eq
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>

<escaped_to_global>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x1, x29, #0x20
               	ldr	x0, [x1]
               	cmp	x0, #0x4
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x2, [x1, #0x8]
               	cmp	x2, #0x1
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	cmp	x2, #0x2
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x0, [x1, #0x18]
               	cmp	x0, #0x3
               	cset	x0, eq
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>

<escaped_as_argument>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	cmp	x1, #0x4
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	cmp	x2, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	cmp	x3, #0x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	cmp	x4, #0x3
               	cset	x0, eq
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>

<clobbered_then_assigned>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x1, x29, #0x20
               	ldr	x0, [x1]
               	cmp	x0, #0x7
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x2, [x1, #0x8]
               	cmp	x2, #0x8
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	cmp	x2, #0x9
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x0, [x1, #0x18]
               	cmp	x0, #0xa
               	cset	x0, eq
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>

<escape_across_iterations>:
               	stp	x20, x21, [sp, #-0x90]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x22, #0x1               // =1
               	mov	x21, #0x0               // =0
               	sub	x20, x29, #0x60
               	cbz	x21, <addr>
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x20]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x20, #0x10]
               	cbnz	w21, <addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x1
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x1, [x20, #0x8]
               	cmp	x1, #0x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x1, [x20, #0x10]
               	cmp	x1, #0x3
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x0, [x20, #0x18]
               	cmp	x0, #0x4
               	cset	x0, eq
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	cmp	w21, #0x1
               	b.ne	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x4
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x1, [x20, #0x8]
               	cmp	x1, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x1, [x20, #0x10]
               	cmp	x1, #0x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x0, [x20, #0x18]
               	cmp	x0, #0x3
               	cset	x0, eq
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	sub	x1, x29, #0x60
               	ldr	x0, [x1]
               	cmp	x0, #0x3
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x2, [x1, #0x8]
               	cmp	x2, #0x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	cmp	x2, #0x1
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x0, [x1, #0x18]
               	cmp	x0, #0x2
               	cset	x0, eq
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	x8, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	b	<addr>
               	and	x22, x22, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x60
               	str	x1, [x0]
               	add	x21, x21, #0x1
               	cmp	w21, #0x3
               	b.lt	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret

<pointer_to_local>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x1, x29, #0x20
               	ldr	x0, [x1]
               	cmp	x0, #0x4
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x2, [x1, #0x8]
               	cmp	x2, #0x1
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	cmp	x2, #0x2
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x0, [x1, #0x18]
               	cmp	x0, #0x3
               	cset	x0, eq
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>

<regs_through_pointer>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	cmp	x0, #0x3
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x0, [x20, #0x8]
               	cmp	x0, #0x6
               	cset	x0, eq
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<regs_fresh>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	sub	x2, x29, #0x20
               	str	x0, [x2]
               	str	x1, [x2, #0x8]
               	sub	x0, x29, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	bl	<addr>
               	cmp	x0, #0x54
               	cset	x0, eq
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<regs_in_registers>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	mov	x20, x1
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x20, [x0, #0x8]
               	ldr	x21, [x0]
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	add	x0, x21, x20
               	cmp	x0, #0x12
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	cmp	w1, #0x7
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x17, #-0x7              // =-7
               	cmp	w2, w17
               	cset	x0, eq
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, x0
               	b	<addr>

<regs_escaped>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x10
               	ldr	x0, [x1]
               	cmp	x0, #0x2
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x0, [x1, #0x8]
               	cmp	x0, #0x1
               	cset	x0, eq
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<member_of_call>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x14               // =20
               	sub	x8, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldr	x20, [x0, #0x10]
               	mov	x0, #0x1e               // =30
               	bl	<addr>
               	add	x0, x20, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x52
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	x1, [x29, #-0x30]
               	ldur	x2, [x29, #-0x10]
               	add	x1, x1, x2
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
