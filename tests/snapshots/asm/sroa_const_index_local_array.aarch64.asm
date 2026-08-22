
sroa_const_index_local_array.aarch64:	file format elf64-littleaarch64

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

<rounds>:
               	mov	x8, x0
               	mov	x7, x1
               	add	x0, x8, #0x0
               	ldr	x0, [x0]
               	ldr	x1, [x8, #0x8]
               	ldr	x2, [x8, #0x10]
               	ldr	x3, [x8, #0x18]
               	ldr	x4, [x8, #0x20]
               	ldr	x5, [x8, #0x28]
               	ldr	x6, [x8, #0x30]
               	ldr	x8, [x8, #0x38]
               	b	<addr>
               	lsl	x7, x8, #1
               	add	x7, x6, x7
               	lsl	x6, x6, #1
               	add	x6, x5, x6
               	lsl	x5, x5, #1
               	add	x5, x4, x5
               	lsl	x4, x4, #1
               	add	x4, x3, x4
               	lsl	x3, x3, #1
               	add	x3, x2, x3
               	lsl	x2, x2, #1
               	add	x2, x1, x2
               	lsl	x1, x1, #1
               	add	x1, x0, x1
               	lsl	x0, x0, #1
               	eor	x0, x8, x0
               	mov	x8, x7
               	mov	x7, x9
               	sub	x9, x7, #0x1
               	cmp	w7, #0x0
               	b.gt	<addr>
               	add	x0, x0, #0x0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x8
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	add	x1, x0, #0x0
               	mov	x2, #0x7                // =7
               	str	x2, [x1]
               	mov	x1, #0x1118             // =4376
               	str	x1, [x0, #0x8]
               	mov	x1, #0x2229             // =8745
               	str	x1, [x0, #0x10]
               	mov	x1, #0x333a             // =13114
               	str	x1, [x0, #0x18]
               	mov	x1, #0x444b             // =17483
               	str	x1, [x0, #0x20]
               	mov	x1, #0x555c             // =21852
               	str	x1, [x0, #0x28]
               	mov	x1, #0x666d             // =26221
               	str	x1, [x0, #0x30]
               	mov	x1, #0x777e             // =30590
               	str	x1, [x0, #0x38]
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0xbf84            // =49028
               	movk	x17, #0x14e, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
