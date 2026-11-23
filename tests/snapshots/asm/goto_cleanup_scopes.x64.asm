
goto_cleanup_scopes.x64:	file format elf64-x86-64

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

<exits>:
               	xorl	%edx, %edx
               	leaq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jge	<addr>
               	testl	%edi, %edi
               	je	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, <rip> # <addr>
               	movb	$0x64, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	%dl, (%rax,%rsi)
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
               	movl	$0x1, %eax
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
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rdx)
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

<nested>:
               	testl	%edi, %edi
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x63, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
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

<computed>:
               	testl	%edi, %edi
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rax,%rdx)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rax,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, <rip> # <addr>
               	movb	$0x61, (%rax,%rsi)
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
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x21, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	retq
               	leaq	-<rip>, %rcx # <addr>
               	jmp	<addr>

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorl	%edx, %edx
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	<rip>, %rcx
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
               	movq	-0x18(%rbp,%rcx,8), %rcx
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
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%edx, %edx
               	cmovneq	%rax, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movl	$0x1, <rip> # <addr>
               	incq	%rcx
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	jmp	<addr>
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
               	movq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
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
               	movq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
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
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x79, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x78, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rsi,%rax), %rdi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rcx,%rsi)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	leaq	<rip>, %rcx # <addr>
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
               	leaq	<rip>, %rsi # <addr>
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
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
               	leaq	<rip>, %rsi # <addr>
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x2d, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rcx,%rdx)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rcx,%rax)
               	movslq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rsi,%rax), %rdi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%ebx, %ebx
               	movl	%ebx, <rip> # <addr>
               	movb	%bl, <rip> # <addr>
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x5, %ebx
               	jge	<addr>
               	xorl	%r12d, %r12d
               	movl	%r12d, <rip> # <addr>
               	leaq	<rip>, %r13 # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x1, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	movl	%r12d, <rip> # <addr>
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
               	movq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x1, %r14d
               	testq	%r13, %r13
               	je	<addr>
               	movl	%r12d, <rip> # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%r14d, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x10, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	movq	%r15, %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x0, <rip> # <addr>
               	movq	%r14, %r12
               	jmp	<addr>
               	movl	$0x10, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpl	$0x2, %ebx
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testq	%r15, %r15
               	je	<addr>
               	movq	%r15, %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x0, <rip> # <addr>
               	movq	%r14, %r12
               	jmp	<addr>
               	movl	$0x2, %r12d
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testq	%r15, %r15
               	je	<addr>
               	movq	%r15, %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movl	$0x3, %r12d
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	callq	<addr>
               	ud2
               	callq	<addr>
               	ud2
               	callq	<addr>
               	ud2
               	callq	<addr>
               	ud2
               	callq	<addr>
               	ud2
