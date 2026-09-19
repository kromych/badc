
anon_union_nested_init.x64:	file format elf64-x86-64

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

<check_const>:
               	xorl	%eax, %eax
               	retq

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<check_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-0x18(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movb	%bl, (%rdi)
               	movb	%r12b, 0x1(%rdi)
               	leaq	(%rbx,%r12), %rax
               	movb	%al, 0x2(%rdi)
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	movb	%al, 0x3(%rdi)
               	callq	<addr>
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rax
               	movq	%rbx, %rcx
               	imulq	%r12, %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movb	$0x9, (%rax)
               	movb	$0x8, 0x1(%rax)
               	movb	$0x7, 0x2(%rax)
               	movb	$0x6, 0x3(%rax)
               	movl	%ebx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movzbq	(%rax), %rcx
               	xorq	$0x9, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x6, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x3, -0x10(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdi
               	movslq	-0x8(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
