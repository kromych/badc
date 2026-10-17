
call_conv_block_scope.aarch64:	file format elf64-littleaarch64

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

<plainf>:
               	add	x0, x1, x0, lsl #1
               	ret

<ms_ext>:
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<sv_ext>:
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	sub	x0, x0, x1
               	ret

<ms5>:
               	add	x0, x0, x1, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	ret

<sv5>:
               	add	x0, x0, x1, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	ret

<via_typedef>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x23, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	blr	x22
               	add	x0, x23, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<via_declarator>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x23, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	blr	x22
               	add	x0, x23, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<via_static>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	str	x2, [x3]
               	blr	x2
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_list>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	blr	x2
               	ldp	x29, x30, [sp], #0x10
               	ret

<after_declarator>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	ldr	x23, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x2710            // =10000
               	mul	x24, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	blr	x22
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x22, x24, x0
               	mov	x0, x20
               	mov	x1, x21
               	blr	x23
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<shadowed>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x23, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	blr	x22
               	add	x22, x23, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x2710            // =10000
               	mul	x0, x0, x17
               	add	x0, x0, x22
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<leading_and_trailing>:
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	add	x2, x0, x1
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	sub	x0, x0, x1
               	add	x0, x2, x0
               	ret

<with_extern>:
               	mov	x0, #0x15b3             // =5555
               	ret

<through_function_typedef>:
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	add	x2, x0, x1
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	sub	x0, x0, x1
               	add	x0, x2, x0
               	ret

<after_asm_label>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<over_a_list>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x20, x17
               	sub	x1, x1, x21
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
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
               	cmp	x0, #0x905
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x86c7            // =34503
               	movk	x17, #0x3, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x86c5            // =34501
               	movk	x17, #0x3, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0xc35
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x17, #0x15b3            // =5555
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0xc35
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0xc35
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x915
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
