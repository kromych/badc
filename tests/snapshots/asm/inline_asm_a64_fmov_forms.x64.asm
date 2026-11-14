
inline_asm_a64_fmov_forms.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x89abcdef, %ecx       # imm = 0x89ABCDEF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
