
inline_asm_x64_setjmp_region_slices.x64:	file format elf64-x86-64

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

<deep_touch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movslq	%edi, %rdi
               	xorl	%eax, %eax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	(%rcx,%rax), %rdx
               	leaq	(%rdi,%rax), %rcx
               	movb	%cl, (%rdx)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	testl	%edi, %edi
               	jle	<addr>
               	decq	%rdi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rax
               	movsbq	(%rax), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx        # <addr>
               	xorq	%rax, %rax
               	movq	%rbx, (%rdx)
               	movq	%rbp, 0x8(%rdx)
               	movq	%r12, 0x10(%rdx)
               	movq	%rsp, 0x18(%rdx)
               	movq	%r13, 0x20(%rdx)
               	movq	%r14, 0x28(%rdx)
               	movq	%r15, 0x30(%rdx)
               	movq	%rcx, 0x38(%rdx)
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x0, -0x8(%rbp)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %rbp
               	movq	0x10(%rax), %r12
               	movq	0x18(%rax), %rdx
               	movq	0x20(%rax), %r13
               	movq	0x28(%rax), %r14
               	movq	%rdx, %rsp
               	movq	0x30(%rax), %r15
               	movq	0x38(%rax), %rdx
               	jmpq	*%rdx
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
