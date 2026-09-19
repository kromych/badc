
struct_array_elided_runtime.x64:	file format elf64-x86-64

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

<run>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	0x1(%rdi), %rax
               	leaq	0x2(%rdi), %rcx
               	leaq	0x3(%rdi), %rdx
               	cmpl	%edi, %edi
               	jne	<addr>
               	cmpl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	cmpl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x3(%rdi), %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x4(%rdi), %rax
               	cmpl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	cmpl	$0x14, %ebx
               	jge	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
