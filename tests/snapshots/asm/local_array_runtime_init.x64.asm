
local_array_runtime_init.x64:	file format elf64-x86-64

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
               	movw	$0x1234, 0xa(%rax)      # imm = 0x1234
               	leaq	<rip>, %rcx
               	movw	$0x5678, 0xa(%rcx)      # imm = 0x5678
               	movzwq	0xa(%rax), %rax
               	movzwq	0xa(%rcx), %rcx
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	cmpl	$0x477198, %eax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq
