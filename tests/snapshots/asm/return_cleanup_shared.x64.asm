
return_cleanup_shared.x64:	file format elf64-x86-64

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

<three>:
               	movl	$0x7, %eax
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rdx,%rcx)
               	retq
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>

<two_lists>:
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movb	$0x61, (%rcx,%rax)
               	movl	$0xa, %eax
               	retq
               	movl	$0x3, %eax
               	movl	$0x14, %ecx
               	cmpl	$0x1, %edi
               	cmovneq	%rcx, %rax
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	retq

<nested>:
               	movl	$0x5, %eax
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x63, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movb	$0x63, (%rcx,%rax)
               	movl	$0x1e, %eax
               	movl	$0x28, %edx
               	cmpl	$0x2, %edi
               	cmovneq	%rdx, %rax
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	retq

<void_returns>:
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, (%rsi)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movb	$0x62, (%rcx,%rax)
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x2, (%rsi)
               	jmp	<addr>
               	movl	$0x3, (%rsi)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movb	$0x62, (%rcx,%rax)
               	retq

<pairs>:
               	subq	$0x38, %rsp
               	movq	%rdi, (%rsp)
               	testl	%esi, %esi
               	jne	<addr>
               	movq	$0x1, 0x10(%rsp)
               	movq	$0x2, 0x18(%rsp)
               	movq	$0x3, 0x20(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movb	$0x61, (%rcx,%rax)
               	movq	(%rsp), %rax
               	leaq	0x10(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	addq	$0x38, %rsp
               	retq
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	$0x4, 0x10(%rsp)
               	movq	$0x2, 0x18(%rsp)
               	movq	$0x3, 0x20(%rsp)
               	jmp	<addr>
               	movq	$0x4, 0x10(%rsp)
               	movq	$0x8, 0x18(%rsp)
               	movq	$0x3, 0x20(%rsp)
               	jmp	<addr>

<looped>:
               	movl	$0x4, %eax
               	cmpl	$0x4, %edi
               	jne	<addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x63, (%rdx,%rcx)
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
               	subq	$0x28, %rsp
               	xorl	%esi, %esi
               	movl	%esi, (%rsp)
               	movl	%esi, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	nop
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	nopw	(%rax,%rax)
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	callq	<addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	nopl	(%rax,%rax)
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	nop
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	nopl	(%rax,%rax)
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	nop
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	callq	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	nopw	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	nopl	(%rax,%rax)
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	nop
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x28, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	nop
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	movl	(%rsp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	nopl	(%rax,%rax)
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	movl	(%rsp), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	movl	(%rsp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	nopl	(%rax)
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%esi, %esi
               	movl	%esi, <rip> # <addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	cmpq	$0x1, %rax
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	leaq	0x8(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	cmpq	$0x4, %rax
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	leaq	0x8(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	cmpq	$0x4, %rax
               	jne	<addr>
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	nopw	(%rax,%rax)
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	nop
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%edi, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rdx,%rax), %rcx
               	nop
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
