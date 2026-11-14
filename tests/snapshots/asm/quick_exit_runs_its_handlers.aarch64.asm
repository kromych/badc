
quick_exit_runs_its_handlers.aarch64:	file format elf64-littleaarch64

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

<first>:
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	ret

<second>:
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	ret

<by_atexit>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	brk	#0x1

<last>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	mov	x1, #0x5                // =5
               	mov	x2, #0x6                // =6
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x15
               	csel	x0, x1, x2, eq
               	bl	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	brk	#0x1
