
bst_free.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rdi
               	callq	<addr>
               	movq	%rbx, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x18, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rdi, %rdi
               	movq	%r12, (%rax)
               	movq	%rax, %rsi
               	addq	$0x8, %rsi
               	movq	%rdi, (%rsi)
               	movq	%rax, %rdx
               	addq	$0x10, %rdx
               	movq	%rdi, (%rdx)
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rsi
               	cmpq	%rsi, %r12
               	jge	<addr>
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	(%r14), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, (%r14)
               	jmp	<addr>
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %r15
               	addq	$0x10, %r15
               	movq	(%r15), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, (%r15)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x32, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1e, %esi
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	$0x46, %esi
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
