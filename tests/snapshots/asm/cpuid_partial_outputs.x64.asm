
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	cpuid
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	%eax, %esi
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
