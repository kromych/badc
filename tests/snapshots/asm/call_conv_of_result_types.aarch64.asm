
call_conv_of_result_types.aarch64:	file format elf64-littleaarch64

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

<msf>:
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<svf>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sub	x0, x0, x1
               	ret

<get_ms>:
               	cmp	x0, #0x7
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<get_sv>:
               	cmp	x0, #0x8
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<lookup>:
               	cmp	x0, #0x7
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<lookup2>:
               	cmp	x0, #0x8
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<block_prototypes>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cbz	x0, <addr>
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cbz	x0, <addr>
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #-0x1               // =-1
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	b	<addr>

<block_pointers>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x2710            // =10000
               	mul	x22, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x22, x22, x0
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	sub	x0, x0, #0x17
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<nested_declarator>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<file_scope>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	mov	x0, #0x7                // =7
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x2710            // =10000
               	mul	x22, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x22, x22, x0
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<through_parameter>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x2, x0
               	mov	x20, x1
               	mov	x0, #0x7                // =7
               	blr	x2
               	mov	x2, x0
               	mov	x1, #0x3                // =3
               	mov	x0, x20
               	blr	x2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x905
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x85f4            // =34292
               	movk	x17, #0x3, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x905
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x8b75            // =35701
               	movk	x17, #0x3, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
