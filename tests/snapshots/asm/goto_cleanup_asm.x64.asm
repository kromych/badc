
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
               	cmpl	$0x1, %edi
               	je	<addr>
               	cmpl	$0x2, %edi
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x2d, (%rax,%rcx)
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
               	movb	$0x2e, (%rax,%rcx)
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
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
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
               	movl	$0x1, %eax
               	movl	$0x1, %r10d
               	cmpl	$0x1, %r10d
               	je	<addr>
               	movl	$0x1f, %eax
               	cmpl	$0x1, %eax
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
               	xorl	%eax, %eax
               	xorl	%r10d, %r10d
               	cmpl	$0x1, %r10d
               	je	<addr>
               	movl	$0x1e, %eax
               	cmpl	$0x1e, %eax
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
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
