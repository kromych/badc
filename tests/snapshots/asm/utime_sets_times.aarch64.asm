
utime_sets_times.aarch64:	file format elf64-littleaarch64

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

<mtime_of>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	ldr	x0, [x0, #0x58]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	bl	<addr>
               	mov	x5, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x20
               	mov	x4, x21
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x2               // =2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	bl	<addr>
               	mov	x17, #0x8c00            // =35840
               	movk	x17, #0x4786, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0x3               // =3
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
