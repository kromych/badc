
posix_module_headers.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x290
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	cmp	w0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	mov	w0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x280
               	bl	<addr>
               	sub	x0, x29, #0x280
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sub	x0, x29, #0x280
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x280
               	mov	x1, #0xf                // =15
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x280
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sub	x0, x29, #0x280
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0x290
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	str	wzr, [x0]
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
