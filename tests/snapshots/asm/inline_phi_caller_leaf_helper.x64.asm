
inline_phi_caller_leaf_helper.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x6a09e667, %ecx       # imm = 0x6A09E667
               	movl	$0xbb67ae85, %esi       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %r8d       # imm = 0x3C6EF372
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%ecx, %r9d
               	movl	%esi, %ebx
               	movl	%r8d, %r12d
               	movl	%r9d, %r8d
               	movl	%ebx, %r13d
               	andq	%r8, %r13
               	xorq	$-0x1, %r8
               	movl	%r8d, %r8d
               	movl	%r12d, %r12d
               	andq	%r12, %r8
               	xorq	%r13, %r8
               	movl	%r8d, %r8d
               	movl	(%rdi,%rdx,4), %r12d
               	addq	%r12, %r8
               	movl	%r8d, %r8d
               	movl	%r8d, %ecx
               	leaq	0x1(%rdx), %rax
               	movq	%rbx, %r8
               	movq	%r9, %rsi
               	movslq	%eax, %rdx
               	cmpq	$0x8, %rdx
               	jl	<addr>
               	movl	%ecx, %eax
               	movl	%esi, %ecx
               	xorq	%rcx, %rax
               	movl	%r8d, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	movl	$0xff6fffef, %r11d      # imm = 0xFF6FFFEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
