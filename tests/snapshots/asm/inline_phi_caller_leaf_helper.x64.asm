
inline_phi_caller_leaf_helper.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<digest>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r8
               	movq	%rsi, %r9
               	movslq	%r9d, %r9
               	movl	$0x6a09e667, %edx       # imm = 0x6A09E667
               	movl	$0xbb67ae85, %ecx       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %edi       # imm = 0x3C6EF372
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%edx, %ebx
               	movl	%ecx, %r12d
               	movl	%edi, %r13d
               	movl	%ebx, %edi
               	movl	%r12d, %ebx
               	andq	%rdi, %rbx
               	xorq	$-0x1, %rdi
               	movl	%edi, %edi
               	movl	%r13d, %r12d
               	andq	%r12, %rdi
               	xorq	%rbx, %rdi
               	movl	%edi, %edi
               	movl	(%r8,%rsi,4), %ebx
               	addq	%rbx, %rdi
               	movl	%edi, %ebx
               	movl	%ecx, %edi
               	movl	%edx, %ecx
               	movl	%ebx, %edx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	%r9, %rsi
               	jl	<addr>
               	movl	%edx, %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%edi, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
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
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
