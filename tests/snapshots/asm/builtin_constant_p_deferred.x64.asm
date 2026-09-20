
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
               	xorl	%eax, %eax
               	movl	$0x15, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	movslq	-0x8(%rbp), %rcx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x400, %eax            # imm = 0x400
               	leave
               	retq
