
int_literal_boundary_types.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	cmp	x1, x0
               	b.hs	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	b	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	b	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x2, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x8                // =8
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	cmp	x1, x0
               	b.hs	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
