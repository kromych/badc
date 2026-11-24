
select_and_getrusage_have_the_posix_types.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x1c8, %rsp            # imm = 0x1C8
               	leaq	0x10(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rsp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	xorl	%eax, %eax
               	movb	$0x0, 0xb0(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movslq	0x8(%rsp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movq	%rax, %rsi
               	shrq	$0x3d, %rsi
               	addq	%rax, %rsi
               	sarq	$0x3, %rsi
               	movzbq	0xb0(%rsp,%rsi), %rsi
               	movl	$0x1, %edi
               	andq	$0x7, %rax
               	shlxq	%rax, %rdi, %rax
               	orq	%rsi, %rax
               	movb	%al, 0xb0(%rsp,%rdx)
               	xorl	%edx, %edx
               	movl	0x8(%rsp), %eax
               	leaq	0x1(%rax), %rdi
               	leaq	0xb0(%rsp), %rsi
               	leaq	0x10(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	0x8(%rsp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movzbq	0xb0(%rsp,%rdx), %rcx
               	movl	$0x1, %edx
               	andq	$0x7, %rax
               	shlxq	%rax, %rdx, %rax
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	leaq	0x30(%rsp), %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, 0xb0(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movslq	0x8(%rsp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movq	%rax, %rsi
               	shrq	$0x3d, %rsi
               	addq	%rax, %rsi
               	sarq	$0x3, %rsi
               	movzbq	0xb0(%rsp,%rsi), %rsi
               	movl	$0x1, %edi
               	andq	$0x7, %rax
               	shlxq	%rax, %rdi, %rax
               	orq	%rsi, %rax
               	movb	%al, 0xb0(%rsp,%rdx)
               	xorl	%edx, %edx
               	movl	0x8(%rsp), %eax
               	leaq	0x1(%rax), %rdi
               	leaq	0xb0(%rsp), %rsi
               	leaq	0x20(%rsp), %r8
               	leaq	0x30(%rsp), %r9
               	movq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	0x8(%rsp), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rax, %rdx
               	sarq	$0x3, %rdx
               	movzbq	0xb0(%rsp,%rdx), %rcx
               	movl	$0x1, %edx
               	andq	$0x7, %rax
               	shlxq	%rax, %rdx, %rax
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	xorl	%edi, %edi
               	leaq	0x130(%rsp), %rsi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	0x150(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	movq	0x138(%rsp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x4, %eax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	0x8(%rsp), %edi
               	callq	<addr>
               	movl	0xc(%rsp), %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	$0x5, %eax
               	jmp	<addr>
