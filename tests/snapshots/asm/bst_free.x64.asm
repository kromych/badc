
bst_free.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<free_tree>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	0x8(%rbx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rbx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rbx, %rdi
               	popq	%rbx
               	leave
               	jmp	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, %rdi
               	callq	<addr>
               	jmp	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, %rdi
               	callq	<addr>
               	jmp	<addr>
               	retq

<insert>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rbx, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	$0x0, 0x10(%rax)
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	(%r12), %rax
               	cmpq	%rax, %rbx
               	jge	<addr>
               	movq	0x8(%r12), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movq	$0x0, 0x10(%rcx)
               	movq	%rcx, 0x8(%r12)
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	(%rcx), %rax
               	cmpq	%rax, %rbx
               	jge	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x8(%rcx)
               	jmp	<addr>
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x10(%rcx)
               	jmp	<addr>
               	movq	0x10(%r12), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movq	$0x0, 0x10(%rcx)
               	movq	%rcx, 0x10(%r12)
               	jmp	<addr>
               	movq	(%rcx), %rax
               	cmpq	%rax, %rbx
               	jge	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x8(%rcx)
               	jmp	<addr>
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x10(%rcx)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x32, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x1e, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x46, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
