
inline_asm_x64_setcc.x64:	file format elf64-x86-64

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
               	movl	$0x5, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	sete	%al
               	movq	-0x28(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x14, %rax, %rax
               	leaq	(%rax), %rcx
               	movl	$0x3, %edx
               	movl	$0x7, %eax
               	leaq	-0x8(%rbp), %rsi
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setl	%al
               	movq	-0x28(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0xf, %rax, %rax
               	leaq	(%rcx,%rax), %rsi
               	movl	$0x9, %eax
               	movl	$0x4, %edi
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setg	%al
               	movq	-0x28(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movzbq	-0x8(%rbp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x1, %ecx
               	movl	$0x2, %r8d
               	leaq	-0x8(%rbp), %r9
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%r9, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%r8, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	sete	%al
               	movq	-0x28(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movzbq	-0x8(%rbp), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rsi
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setl	%al
               	movq	-0x28(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movzbq	-0x8(%rbp), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rsi, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setg	%al
               	movq	-0x28(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
