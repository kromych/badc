
inline_asm_branch_target_operand.x64:	file format elf64-x86-64

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

<helper_1>:
               	movl	$0x1, %eax
               	retq

<helper_2>:
               	movl	$0x2, %eax
               	retq

<helper_4>:
               	movl	$0x4, %eax
               	retq

<helper_8>:
               	movl	$0x8, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	%r10, -0x38(%rbp)
               	movq	%r11, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	callq	<addr>
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rdx
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdi
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %r10
               	movq	-0x30(%rbp), %r11
               	movslq	-0x10(%rbp), %rax
               	addq	$0x0, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x2, %edx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	%r10, -0x38(%rbp)
               	movq	%r11, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	callq	<addr>
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rdx
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdi
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %r10
               	movq	-0x30(%rbp), %r11
               	movslq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x4, %edx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	%r10, -0x38(%rbp)
               	movq	%r11, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	callq	<addr>
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rdx
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdi
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %r10
               	movq	-0x30(%rbp), %r11
               	movslq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x8, %edx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	%r10, -0x38(%rbp)
               	movq	%r11, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	callq	<addr>
               	movq	-0x28(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rdx
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdi
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %r10
               	movq	-0x30(%rbp), %r11
               	movslq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
