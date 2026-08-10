
builtin_constant_p_deferred.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movl	$0x15, %ecx
               	movl	%ecx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	movslq	-0x8(%rbp), %rcx
               	movl	$0x12, %ecx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x400, %eax            # imm = 0x400
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
