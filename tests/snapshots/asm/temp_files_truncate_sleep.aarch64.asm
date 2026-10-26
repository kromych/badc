
temp_files_truncate_sleep.aarch64:	file format elf64-littleaarch64

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

<size_of>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x690
               	str	x20, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	sub	x0, x29, #0x658
               	mov	x1, #0x200              // =512
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x20
               	bl	<addr>
               	sub	x0, x29, #0x458
               	mov	x1, #0x200              // =512
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x20
               	bl	<addr>
               	sub	x0, x29, #0x658
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.lt	<addr>
               	sub	x0, x29, #0x658
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xa                // =10
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x658
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x658
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x658
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x458
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x458
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x258
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x458
               	bl	<addr>
               	sub	x0, x29, #0x258
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sub	x0, x29, #0x258
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x458
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x668
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	bl	<addr>
               	str	wzr, [x0]
               	sub	x0, x29, #0x668
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x16
               	b.ne	<addr>
               	sub	x0, x29, #0x668
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	str	wzr, [x0]
               	sub	x0, x29, #0x668
               	bl	<addr>
               	cbnz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x678
               	bl	<addr>
               	mov	x0, #0x7d0              // =2000
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x668
               	bl	<addr>
               	ldr	x0, [sp, #0x28]
               	ldr	x1, [sp, #0x18]
               	sub	x0, x0, x1
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	mul	x0, x0, x17
               	ldr	x1, [sp, #0x30]
               	ldr	x2, [sp, #0x20]
               	sub	x1, x1, x2
               	add	x0, x0, x1
               	mov	x17, #0x8480            // =33920
               	movk	x17, #0x1e, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	add	sp, sp, #0x690
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
