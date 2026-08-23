
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
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
               	movl	$0xbb67ae85, %edx       # imm = 0xBB67AE85
               	movl	$0x3c6ef372, %esi       # imm = 0x3C6EF372
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%ecx, %r8d
               	movl	%edx, %r9d
               	movl	%esi, %ebx
               	movl	%r8d, %esi
               	movl	%r9d, %r12d
               	andq	%rsi, %r12
               	xorq	$-0x1, %rsi
               	movl	%esi, %esi
               	movl	%ebx, %ebx
               	andq	%rbx, %rsi
               	xorq	%r12, %rsi
               	movl	%esi, %ebx
               	movslq	%eax, %rsi
               	movl	(%rdi,%rsi,4), %r12d
               	addq	%r12, %rbx
               	movl	%ebx, %ebx
               	movl	%ebx, %ecx
               	leaq	0x1(%rsi), %rax
               	movq	%r9, %rsi
               	movq	%r8, %rdx
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	xorq	%rcx, %rax
               	movl	%esi, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	movl	$0xff6fffef, %r11d      # imm = 0xFF6FFFEF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
