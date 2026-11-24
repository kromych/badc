
int128_mul.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x18]
               	mul	x1, x0, x2
               	umulh	x2, x0, x2
               	mov	x17, #0x5d10            // =23824
               	movk	x17, #0x4bb, lsl #16
               	movk	x17, #0x45c, lsl #32
               	movk	x17, #0xe5cf, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ret
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mul	x3, x1, x1
               	umulh	x4, x1, x1
               	mul	x0, x1, x2
               	add	x4, x4, x0
               	add	x4, x4, x0
               	mov	x17, #0xa100            // =41216
               	movk	x17, #0x9734, lsl #16
               	movk	x17, #0xc789, lsl #32
               	movk	x17, #0x6189, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x17, #0x218             // =536
               	movk	x17, #0x6042, lsl #16
               	movk	x17, #0x4ab6, lsl #32
               	movk	x17, #0x95fa, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	ret
               	mov	x0, #0x7c15             // =31765
               	movk	x0, #0x7f4a, lsl #16
               	movk	x0, #0x79b9, lsl #32
               	movk	x0, #0x9e37, lsl #48
               	mul	x3, x1, x0
               	umulh	x1, x1, x0
               	madd	x1, x2, x0, x1
               	mov	x17, #0x6250            // =25168
               	movk	x17, #0xfb12, lsl #16
               	movk	x17, #0xfba, lsl #32
               	movk	x17, #0xe1dd, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x17, #0x37a7            // =14247
               	movk	x17, #0x84a5, lsl #16
               	movk	x17, #0x4fc9, lsl #32
               	movk	x17, #0xab46, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
