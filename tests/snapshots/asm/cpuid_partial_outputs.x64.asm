
cpuid_partial_outputs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<leaf_max_partial>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rax, %r10
               	movq	%rax, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x8(%rbp), %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<leaf_max_full>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rax, %r10
               	movq	%rax, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x8(%rbp), %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	cmpq	%rax, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
