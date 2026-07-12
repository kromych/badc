
unsigned_signed_relational_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
