
struct_by_value_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<make_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	%esi, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<clobber>:
               	leaq	0x121589(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<sum_pair_pair>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0xb, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x16, %edi
               	callq	<addr>
               	movslq	%ebx, %rbx
               	movslq	%eax, %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	addq	$0x121589, %rax         # imm = 0x121589
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x63, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xb, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x16, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ebx, %rax
               	movslq	%ecx, %rcx
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0xc8, %edi
               	callq	<addr>
               	movslq	%ebx, %rbx
               	movslq	%eax, %r12
               	movl	$0x12c, %edi            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x190, %edi            # imm = 0x190
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%r13d, %rax
               	movslq	%ecx, %rcx
               	cmpq	$0x64, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xc8, %r12
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x190, %rcx            # imm = 0x190
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	(%rbx,%r13), %rcx
               	movslq	%ecx, %rcx
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
