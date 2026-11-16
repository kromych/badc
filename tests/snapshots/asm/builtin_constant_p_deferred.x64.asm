
builtin_constant_p_deferred.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%ecx, %ecx
               	movl	$0x15, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	-0x8(%rbp), %eax
               	movl	-0x8(%rbp), %eax
               	addq	%rax, %rax
               	movl	$0x400, %edx            # imm = 0x400
               	cmpl	$0x2a, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	leave
               	retq
