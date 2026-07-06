
sroa_const_index_local_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x9, x1
               	add	x1, x0, #0x0
               	ldr	x2, [x1]
               	ldr	x3, [x0, #0x8]
               	ldr	x4, [x0, #0x10]
               	ldr	x5, [x0, #0x18]
               	ldr	x6, [x0, #0x20]
               	ldr	x7, [x0, #0x28]
               	ldr	x8, [x0, #0x30]
               	ldr	x1, [x0, #0x38]
               	b	<addr>
               	lsl	x0, x1, #1
               	add	x0, x8, x0
               	lsl	x8, x8, #1
               	add	x8, x7, x8
               	lsl	x7, x7, #1
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
               	eor	x2, x1, x2
               	mov	x1, x0
               	sxtw	x0, w9
               	sub	x9, x0, #0x1
               	cmp	x0, #0x0
               	b.gt	<addr>
               	add	x0, x2, #0x0
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	add	x0, x0, x8
               	add	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x0
               	mov	x1, #0x7                // =7
               	str	x1, [x0]
               	sub	x0, x29, #0x40
               	mov	x1, #0x1118             // =4376
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x40
               	mov	x1, #0x2229             // =8745
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x40
               	mov	x1, #0x333a             // =13114
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x40
               	mov	x1, #0x444b             // =17483
               	str	x1, [x0, #0x20]
               	sub	x0, x29, #0x40
               	mov	x1, #0x555c             // =21852
               	str	x1, [x0, #0x28]
               	sub	x0, x29, #0x40
               	mov	x1, #0x666d             // =26221
               	str	x1, [x0, #0x30]
               	sub	x0, x29, #0x40
               	mov	x1, #0x777e             // =30590
               	str	x1, [x0, #0x38]
               	sub	x0, x29, #0x40
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0xbf84            // =49028
               	movk	x17, #0x14e, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
