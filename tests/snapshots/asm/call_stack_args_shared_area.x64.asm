
call_stack_args_shared_area.x64:	file format elf64-x86-64

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

<sum10>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	retq

<sum11>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movq	<rip>, %rax # <addr>
               	subq	$0x20, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	$0x9, 0x10(%rsp)
               	movq	$0xa, 0x18(%rsp)
               	callq	*%rax
               	addq	$0x20, %rsp
               	movq	%rax, %rbx
               	movl	$0xa, %edi
               	movl	$0x9, %esi
               	movl	$0x8, %edx
               	movl	$0x7, %ecx
               	movl	$0x6, %r8d
               	movl	$0x5, %r9d
               	movq	<rip>, %rax # <addr>
               	subq	$0x30, %rsp
               	movq	$0x4, (%rsp)
               	movq	$0x3, 0x8(%rsp)
               	movq	$0x2, 0x10(%rsp)
               	movq	$0x1, 0x18(%rsp)
               	movq	$0x0, 0x20(%rsp)
               	callq	*%rax
               	addq	$0x30, %rsp
               	addq	%rbx, %rax
               	subq	$0x6e, %rax
               	popq	%rbx
               	leave
               	retq
