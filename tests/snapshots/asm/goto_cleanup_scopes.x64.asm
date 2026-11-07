
goto_cleanup_scopes.x64:	file format elf64-x86-64

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

<exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, %rdx
               	movl	%ecx, -0x8(%rbp)
               	movl	%ecx, -0x8(%rbp)
               	movl	%ecx, -0x8(%rbp)
               	movl	%ecx, -0x8(%rbp)
               	testl	%edi, %edi
               	je	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x64, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x63, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x62, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x61, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	jmp	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x64, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x63, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x2e, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x62, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x61, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	incq	%rdx
               	cmpl	$0x2, %edx
               	jl	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rdx)
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x64, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x63, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x64, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x63, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x64, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x63, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x63, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x64, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x63, (%rcx,%rax)
               	movslq	<rip>, %rax # <addr>
               	movb	$0x0, (%rcx,%rax)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	jmp	<addr>

<from_case>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	cmpl	$0x1, %edi
               	jl	<addr>
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x2d, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	jmp	<addr>

<computed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, <rip> # <addr>
               	movb	$0x62, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rax,%rdx)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	jmpq	*%rcx
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x7c, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x21, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	leave
               	retq
               	leaq	-<rip>, %rcx # <addr>
               	jmp	<addr>

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%edx, %edx
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	-0x8(%rbp), %rcx
               	movq	%rdx, %rax
               	jmpq	*%rcx
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x78, (%rcx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	%dl, (%rcx,%rsi)
               	leaq	<rip>, %rcx # <addr>
               	incq	%rax
               	movzbq	(%rcx,%rax), %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	jmpq	*%rcx
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, <rip> # <addr>
               	movq	%rcx, -0x8(%rbp)
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, <rip> # <addr>
               	movq	%rcx, -0x28(%rbp)
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movq	%rcx, -0x28(%rbp)
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	leaq	<rip>, %rdx # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %esi # <addr>
               	incq	%rsi
               	movl	%esi, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	movl	%ecx, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	%rax, %rcx
               	movl	$0x1, <rip> # <addr>
               	movq	%rdx, -0x8(%rbp)
               	incq	%rcx
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %esi # <addr>
               	incq	%rsi
               	movl	%esi, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %esi # <addr>
               	incq	%rsi
               	movl	%esi, <rip> # <addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%rax, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, <rip> # <addr>
               	movq	%rcx, -0x8(%rbp)
               	movl	<rip>, %ecx # <addr>
               	movl	%ecx, -0x10(%rbp)
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	-0x10(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx # <addr>
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movsbq	(%rdx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx # <addr>
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x78, -0x10(%rbp)
               	movl	$0x79, -0x8(%rbp)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x79, (%rdx,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rdx,%rcx)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rdx,%rax)
               	movslq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rdx,%rcx)
               	movl	-0x10(%rbp), %esi
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	%sil, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rdx # <addr>
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsbq	(%rsi,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x0, -0x28(%rbp)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rcx,%rsi)
               	movl	$0x0, -0x28(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	movl	$0x0, -0x28(%rbp)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx # <addr>
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movsbq	(%rdx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%ebx, %ebx
               	movl	%ebx, <rip> # <addr>
               	movb	%bl, <rip> # <addr>
               	xorl	%r12d, %r12d
               	movl	%r12d, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x1, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	%rcx, -0x28(%rbp)
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	%r12d, (%rax)
               	movl	<rip>, %eax # <addr>
               	imulq	$0x64, %rax, %rax
               	addq	%r12, %rax
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx,%rbx,4), %ecx
               	cmpl	%ecx, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx,%rbx,4), %ecx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x1, %r13d
               	movq	-0x28(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	%r12d, (%rax)
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%r13d, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	%rcx, -0x20(%rbp)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x18(%rbp)
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	movq	-0x18(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x0, (%rax)
               	movq	%r13, %r12
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	cmpl	$0x2, %ebx
               	jne	<addr>
               	movq	-0x10(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	-0x18(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x0, (%rax)
               	movq	%r13, %r12
               	jmp	<addr>
               	movl	$0x2, %r12d
               	movq	-0x10(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	-0x18(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x0, (%rax)
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	movq	%rdi, -0x8(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x3, %ebx
               	jne	<addr>
               	movq	-0x8(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x3, %r12d
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x5, %ebx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
