
inline_recursive_frame_bound.x64:	file format elf64-x86-64

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

<scale>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<rec>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %r15
               	movq	%rsi, %r14
               	movslq	%r14d, %r14
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %r13
               	leaq	(%r14,%r12), %rdi
               	callq	<addr>
               	movl	%eax, (%r13,%r12,4)
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %r12
               	cmpq	$0x40, %r12
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rbx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdx
               	movslq	(%rdx,%rcx,4), %rdx
               	addq	%rdx, %rbx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	movl	%ebx, (%r15)
               	testq	%r14, %r14
               	jg	<addr>
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x1(%r14), %rsi
               	movq	%r15, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq

<once>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rsi, %rsi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x17e0, %rax           # imm = 0x17E0
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x17e0, %rax           # imm = 0x17E0
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
