
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
               	xorq	%rcx, %rcx
               	movl	$0x15, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	addq	%rax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x400, %ecx            # imm = 0x400
               	movslq	%ecx, %rax
               	leave
               	retq
