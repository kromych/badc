
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
               	subq	$0x80, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cpuid
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	-0x68(%rbp), %rbx
               	movl	-0x10(%rbp), %ecx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x28(%rbp), %r8
               	xorq	%rax, %rax
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	cpuid
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x58(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x50(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x48(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	-0x68(%rbp), %rbx
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
