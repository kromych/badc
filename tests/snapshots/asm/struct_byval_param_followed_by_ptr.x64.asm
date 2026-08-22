
struct_byval_param_followed_by_ptr.x64:	file format elf64-x86-64

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
               	xorq	%r13, %r13
               	movl	%r13d, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	cmpq	$0x2a, %rdx
               	je	<addr>
               	movl	$0x1e, %r12d
               	movslq	%r12d, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x28(%rbp), %rdx
               	movslq	(%rax), %rcx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x28(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x28(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r13, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	movq	%r13, %r12
               	jmp	<addr>
