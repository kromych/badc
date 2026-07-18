
inline_phi_caller_leaf_helper.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
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
               	leaq	-0x20(%rbp), %r8
               	movl	$0x6a09e667, %edx       # imm = 0x6A09E667
               	movl	$0xbb67ae85, %ecx       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %edi       # imm = 0x3C6EF372
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%edx, %r9d
               	movl	%ecx, %ebx
               	movl	%edi, %r12d
               	movl	%r9d, %edi
               	movl	%ebx, %r9d
               	andq	%rdi, %r9
               	xorq	$-0x1, %rdi
               	movl	%edi, %edi
               	movl	%r12d, %ebx
               	andq	%rbx, %rdi
               	xorq	%r9, %rdi
               	movl	%edi, %edi
               	movl	(%r8,%rsi,4), %r9d
               	addq	%r9, %rdi
               	movl	%edi, %r9d
               	movl	%ecx, %edi
               	movl	%edx, %ecx
               	movl	%r9d, %edx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x8, %rsi
               	jl	<addr>
               	movl	%edx, %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%edi, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	movl	$0xff6fffef, %r11d      # imm = 0xFF6FFFEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
