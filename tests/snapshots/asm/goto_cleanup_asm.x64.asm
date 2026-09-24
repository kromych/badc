
goto_cleanup_asm.x64:	file format elf64-x86-64

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

<by_asm>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movq	%rdi, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x2d, (%rcx,%rdx)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x62, (%rcx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x2e, (%rcx,%rdx)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rcx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leave
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x62, (%rcx,%rdx)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rcx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x62, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
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
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
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
               	leaq	<rip>, %rdx
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rdx)
               	movl	$0x1, %ecx
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1f, %ecx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1e, %ecx
               	cmpl	$0x1e, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
