
inline_asm_a64_fmov_top_half.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x123456789abcdf0, %r11 # imm = 0xFEDCBA9876543210
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
