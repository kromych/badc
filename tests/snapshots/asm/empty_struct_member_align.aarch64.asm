
empty_struct_member_align.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x0, sp
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	mov	x0, sp
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x40]
               	mov	x0, sp
               	add	x0, x0, #0x40
               	mov	x1, sp
               	sub	x0, x0, x1
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	sub	sp, x29, #0x80
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x80
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
