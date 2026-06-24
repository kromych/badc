
inline_phi_caller_leaf_helper.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mix>:
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	andq	%rax, %rcx
               	xorq	$-0x1, %rax
               	movl	%eax, %eax
               	movl	%edx, %edx
               	andq	%rdx, %rax
               	xorq	%rcx, %rax
               	retq

<digest>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%esi, %rsi
               	movl	$0x6a09e667, %r9d       # imm = 0x6A09E667
               	movl	$0xbb67ae85, %r8d       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %edx       # imm = 0x3C6EF372
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	%rsi, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movl	%r9d, %eax
               	movl	%r8d, %ebx
               	movl	%edx, %edx
               	movl	%eax, %eax
               	movl	%ebx, %ebx
               	andq	%rax, %rbx
               	xorq	$-0x1, %rax
               	movl	%eax, %eax
               	movl	%edx, %edx
               	andq	%rdx, %rax
               	xorq	%rbx, %rax
               	movslq	%ecx, %rdx
               	movl	(%rdi,%rdx,4), %edx
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%r8d, %edx
               	movl	%r9d, %r8d
               	movl	%eax, %r9d
               	jmp	<addr>
               	movl	%r9d, %eax
               	movl	%r8d, %ecx
               	xorq	%rcx, %rax
               	movl	%edx, %ecx
               	xorq	%rcx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	movl	$0xff6fffef, %r11d      # imm = 0xFF6FFFEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
