
select_and_getrusage_have_the_posix_types.x64:	file format elf64-x86-64

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
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	leaq	-0x1b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1a0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1b8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x1b4(%rbp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorl	%eax, %eax
               	movb	$0x0, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rcx
               	movslq	-0x1b8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movq	%rax, %rsi
               	shrq	$0x3d, %rsi
               	addq	%rsi, %rax
               	sarq	$0x3, %rax
               	movzbq	(%rcx,%rax), %rax
               	movl	$0x1, %esi
               	movl	-0x1b8(%rbp), %edi
               	andq	$0x7, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rax
               	movb	%al, (%rcx,%rdx)
               	xorl	%edx, %edx
               	movl	-0x1b8(%rbp), %eax
               	leaq	0x1(%rax), %rdi
               	leaq	-0x110(%rbp), %rsi
               	leaq	-0x1b0(%rbp), %r8
               	movq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rcx
               	movslq	-0x1b8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movzbq	(%rcx,%rdx), %rcx
               	movl	$0x1, %edx
               	andq	$0x7, %rax
               	shlxq	%rax, %rdx, %rax
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x190(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x110(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rcx
               	movslq	-0x1b8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movq	%rax, %rsi
               	shrq	$0x3d, %rsi
               	addq	%rsi, %rax
               	sarq	$0x3, %rax
               	movzbq	(%rcx,%rax), %rax
               	movl	$0x1, %esi
               	movl	-0x1b8(%rbp), %edi
               	andq	$0x7, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rax
               	movb	%al, (%rcx,%rdx)
               	xorl	%edx, %edx
               	movl	-0x1b8(%rbp), %eax
               	leaq	0x1(%rax), %rdi
               	leaq	-0x110(%rbp), %rsi
               	leaq	-0x1a0(%rbp), %r8
               	leaq	-0x190(%rbp), %r9
               	movq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rcx
               	movslq	-0x1b8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movzbq	(%rcx,%rdx), %rcx
               	movl	$0x1, %edx
               	andq	$0x7, %rax
               	shlxq	%rax, %rdx, %rax
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	-0x90(%rbp), %rsi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x70(%rbp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	movq	-0x88(%rbp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	-0x1b8(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x1b4(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	jmp	<addr>
