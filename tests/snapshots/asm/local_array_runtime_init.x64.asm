
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
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0xa(%rax)
               	leaq	<rip>, %rcx
               	movl	$0x5678, %edx           # imm = 0x5678
               	movw	%dx, 0xa(%rcx)
               	movzwq	0xa(%rax), %rax
               	movzwq	0xa(%rcx), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x477198, %eax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	retq
