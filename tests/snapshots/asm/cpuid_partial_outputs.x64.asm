
cpuid_partial_outputs.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	cpuid
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %esi
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x10(%rbp)
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x28(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %esi
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
