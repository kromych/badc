
return_cleanup_shared.x64:	file format elf64-x86-64

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

<three>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	<rip>, %rsi # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rsi,%rcx)
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leave
               	retq
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>

<two_lists>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x8(%rbp)
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rdx,%rax)
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x2, -0x8(%rbp)
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x3, %eax
               	leaq	<rip>, %rsi # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rsi,%rcx)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	leaq	<rip>, %rsi # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rsi,%rcx)
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leave
               	retq
               	movl	$0x14, %eax
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x8(%rbp)
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x63, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leave
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x63, (%rcx,%rax)
               	cmpl	$0x2, %edi
               	jne	<addr>
               	movl	$0x1e, %eax
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leave
               	retq
               	movl	$0x28, %eax
               	jmp	<addr>

<void_returns>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x8(%rbp)
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, (%rsi)
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rdx,%rax)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	leave
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x2, (%rsi)
               	jmp	<addr>
               	movl	$0x3, (%rsi)
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rdx,%rax)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	leave
               	retq

<pairs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movl	$0x4, -0x20(%rbp)
               	testl	%esi, %esi
               	jne	<addr>
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x2, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rdx,%rax)
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movq	-0x40(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leave
               	retq
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	$0x4, -0x18(%rbp)
               	movq	$0x2, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	jmp	<addr>
               	movq	$0x4, -0x18(%rbp)
               	movq	$0x8, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	jmp	<addr>

<looped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x4, %eax
               	cmpl	$0x4, %edi
               	jne	<addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	<rip>, %rsi # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x63, (%rsi,%rcx)
               	leave
               	retq
               	movl	$0x5, %eax
               	cmpl	$0x5, %edi
               	je	<addr>
               	movl	$0x6, %eax
               	cmpl	$0x6, %edi
               	je	<addr>
               	movl	$0x7, %eax
               	cmpl	$0x7, %edi
               	je	<addr>
               	movl	$0x8, %eax
               	cmpl	$0x8, %edi
               	je	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorl	%esi, %esi
               	movl	%esi, -0x20(%rbp)
               	movl	%esi, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	callq	<addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	callq	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x28, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	%esi, <rip> # <addr>
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	$0x1, %rax
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	cmpq	$0x4, %rax
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	cmpq	$0x4, %rax
               	jne	<addr>
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %esi # <addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movsbq	(%rcx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
